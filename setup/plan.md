# OpenCode Dotfiles — AI Setup Plan

Execute this plan **phase by phase** when the user says "setup this machine",
"setup", "instalar en esta máquina", or equivalent.

> **Rule**: Ask the user before each phase unless they said "auto" or "automatic".
> **Rule**: After each phase, summarize what was done and ask: "Continue to next phase?"
> **Rule**: If something fails, explain the error, suggest a fix, and let the user resolve before retrying.

---

## Before You Begin — What the USER must do first

These steps need to happen **before opening OpenCode**, because this config (AGENTS.md,
setup/plan.md) is what tells the AI what to do. The AI can't read the plan until the
config is in place.

Share these instructions with the user:

```text
1. Install git: https://git-scm.com/downloads/win  (or `winget install git`)
2. Open a NEW PowerShell window (so git is in PATH)
3. Install scoop:
       Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
       irm get.scoop.sh | iex
4. Install OpenCode:
       scoop install opencode
5. Clone this config repo:
       git clone https://github.com/WilberHernan/OpenCode-Will.git "$env:USERPROFILE\.config\opencode"
6. Open OpenCode (Win+R → type "opencode" → Enter)
7. Say: "setup this machine" — and I (the AI) will handle everything else.
```

Verify these steps were done before proceeding. If the repo isn't cloned yet, tell the
user to close OpenCode, run step 5 above in PowerShell, then reopen OpenCode.

---

## Phase 0: Verify Prerequisites

The user should have done these manually. This phase VERIFIES they exist.

### 0.1 Detect OS
```powershell
[System.Environment]::OSVersion.VersionString
```

### 0.2 Verify git
```powershell
git --version
```
If not found: tell the user to install from https://git-scm.com/downloads/win and reopen PowerShell.

### 0.3 Verify PowerShell version (5.1+)
```powershell
$PSVersionTable.PSVersion
```

### 0.4 Verify scoop is installed
```powershell
scoop --version
```
If not found: run `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser; irm get.scoop.sh | iex`

### 0.5 Verify Node.js/npm — needed for MCPs and plugins
```powershell
node --version
npm --version
```
If not found: guide user to install from https://nodejs.org/ (LTS version, default options).
After install: close and reopen PowerShell or run `refreshenv`.

### 0.6 Verify Go — needed for engram binary
```powershell
go version
```
If not found: guide user to install from https://go.dev/dl/ (default options are fine).
After install: close and reopen PowerShell or run `refreshenv` so `$env:USERPROFILE\go\bin` is in PATH.

---

## Phase 1: Verify OpenCode Installation

The user should have installed OpenCode before opening it.

### 1.1 Verify installation
```powershell
opencode version
```
If not found: run `scoop install opencode`, then restart OpenCode.

---

## Phase 2: Verify Config is Cloned

The user should have cloned the repo to `%USERPROFILE%\.config\opencode`.

### 2.1 Check the config directory
```powershell
$configDir = "$env:USERPROFILE\.config\opencode"
if (Test-Path "$configDir\.git") {
    Write-Host "✅ Config repo is cloned"
    Set-Location $configDir
    git status
} else {
    Write-Host "❌ Config repo not found at $configDir"
    Write-Host "Close OpenCode, then run this in PowerShell:"
    Write-Host "git clone https://github.com/WilberHernan/OpenCode-Will.git `"$configDir`""
    Write-Host "Then reopen OpenCode and say 'setup this machine' again."
}
```

### 2.2 If updating an existing installation
```powershell
$configDir = "$env:USERPROFILE\.config\opencode"
if (Test-Path "$configDir\.git") {
    Set-Location $configDir
    git pull
} else {
    Write-Host "Not a git repo. Can't pull."
}
```

---

## Phase 3: System Dependencies

### 3.1 Install scoop packages
```powershell
scoop install sox whisper-cpp ollama
```
These are idempotent — scoop skips already-installed packages.

### 3.2 Install npm dependencies
```powershell
cd $env:USERPROFILE\.config\opencode
npm install
```
This installs `@opencode-ai/plugin` and `unique-names-generator`.

### 3.3 Install engram binary
```powershell
go install github.com/engramhq/engram@latest
```
This puts `engram.exe` in `$env:USERPROFILE\go\bin\`. If Go is not in PATH, guide the user.

### 3.4 Install / update gentle-ai CLI
```powershell
go install github.com/gentleman-programming/gentle-ai/cmd/gentle-ai@latest
```
This is used by the `background-agents` plugin to regenerate the skill registry
at startup. If not present, the plugin logs a warning and skips the refresh.

### 3.5 Verify Go tools
```powershell
gentle-ai version
engram version 2>$null; if ($?) { Write-Host "engram: OK" } else { Write-Host "engram: installed but version check not supported" }
```
Expected: both tools are found without errors.

---

## Phase 4: Download ML Models

### 4.1 Download whisper model
```powershell
mkdir -Force $env:USERPROFILE\.local\share\whisper-cpp
whisper-cpp -m download -M base
```
If the download fails, try again or suggest using a VPN.

### 4.2 Install Ollama (if not already installed via scoop)
If Ollama wasn't installed via `scoop install ollama` above (or is not working), install the Windows version from https://ollama.com/ — it runs as a proper Windows background service.

### 4.3 Pull Ollama model
```powershell
ollama pull qwen2.5:0.5b
```
> **Note**: This downloads ~397 MB. It may take a few minutes.
> If `ollama pull` fails: make sure Ollama is running. On Windows, look for the Ollama icon in the system tray.
> If not running: start it via `ollama serve` (opens a background window — this is normal).

### 4.4 Verify Ollama responds
```powershell
$body = @{ model = "qwen2.5:0.5b"; prompt = "hi"; stream = $false } | ConvertTo-Json
Invoke-RestMethod -Uri "http://127.0.0.1:11434/api/generate" -Method Post -Body $body -ContentType "application/json"
```
Expected: a JSON response with `"response"` field with a short text answer.
Wait a moment, then verify it responds:
```powershell
$body = @{ model = "qwen2.5:0.5b"; prompt = "hi"; stream = $false } | ConvertTo-Json
Invoke-RestMethod -Uri "http://127.0.0.1:11434/api/generate" -Method Post -Body $body -ContentType "application/json"
```
Expected: a JSON response with `"response"` field. If it fails, ollama may still be starting — wait 10s and retry.

---

## Phase 5: API Keys

### 5.1 Ask the user for required keys

| Key | Source | Required | Purpose |
|-----|--------|----------|---------|
| `MAGIC_API_KEY` | https://21st.dev | Yes | Magic/21st.dev MCP for UI component generation |

Ask the user interactively:
```
"OpenCode needs your Magic API key (21st.dev) for UI components.
You can find it at https://21st.dev in your account settings.
Paste the key below (it will NOT be displayed):"
```

Store the key in a secure location. Options:
- **Recommended**: Pass it as an environment variable. Add to `$PROFILE`:
  ```powershell
  [Environment]::SetEnvironmentVariable("MAGIC_API_KEY", "<key>", "User")
  ```
- **Alternative**: Let the setup script inject it directly into `opencode.json` (less secure).

---

## Phase 6: Generate `opencode.json`

### 6.1 Read the template
```powershell
$template = Get-Content "$env:USERPROFILE\.config\opencode\opencode.template.json" -Raw
```

### 6.2 Replace placeholders

| Placeholder | Value |
|---|---|
| `{{OPENCODE_CONFIG_DIR}}` | `$env:USERPROFILE\.config\opencode` (replace `\` with `\\`) |
| `{{ENGRAM_BIN_PATH}}` | Full path to `engram.exe` (from `Get-Command engram` or `$env:USERPROFILE\go\bin\engram.exe`) |
| `{{MAGIC_API_KEY}}` | The API key from Phase 5 |

PowerShell replacement:
```powershell
$configDir = "$env:USERPROFILE\.config\opencode"
$engramPath = if (Get-Command engram -ErrorAction SilentlyContinue) {
    (Get-Command engram).Source
} else {
    "$env:USERPROFILE\go\bin\engram.exe"
}
$apiKey = $env:MAGIC_API_KEY

$result = $template -replace '{{OPENCODE_CONFIG_DIR}}', ($configDir -replace '\\', '\\')
$result = $result -replace '{{ENGRAM_BIN_PATH}}', ($engramPath -replace '\\', '\\')
$result = $result -replace '{{MAGIC_API_KEY}}', $apiKey
```

### 6.3 Write the generated file
```powershell
$result | Set-Content "$env:USERPROFILE\.config\opencode\opencode.json" -NoNewline
```

### 6.4 Verify JSON is valid
```powershell
$result | ConvertFrom-Json | Out-Null
Write-Host "JSON is valid"
```

---

## Phase 7: Verification

### 7.1 Verify Go CLI tools
```powershell
gentle-ai version
engram version 2>$null; if ($?) { Write-Host "engram: OK" } else { Write-Host "engram: installed (version check may not be supported)" }
```

### 7.2 Test voice pipeline
```powershell
# Test recording
rec -q -r 16000 -c 1 -b 16 "$env:USERPROFILE\Desktop\test.wav" trim 0 3
# Test transcription
whisper-cpp -m base -f "$env:USERPROFILE\Desktop\test.wav"
```

### 7.3 End-to-end smoke test — everything must work

Run these checks. If any fail, stop and fix before proceeding.

#### 7.3.1 Skill registry
```powershell
gentle-ai skill-registry refresh --cwd "$env:USERPROFILE\.config\opencode"
```
Expected: completes without errors. Shows count of indexed skills.

#### 7.3.2 Engram connectivity
```powershell
engram doctor --json 2>$null
```
Or if engram doctor doesn't exist:
```powershell
engram --help 2>$null; if ($?) { Write-Host "✅ engram CLI responds" } else { Write-Host "❌ engram not found" }
```

#### 7.3.3 API key validation
Verify the Magic API key is set:
```powershell
if ($env:MAGIC_API_KEY) {
    Write-Host "✅ MAGIC_API_KEY is set ($($env:MAGIC_API_KEY.Length) chars)"
} else {
    Write-Host "❌ MAGIC_API_KEY is NOT set — magic MCP will fail"
}
```

#### 7.3.4 opencode.json is valid and has all MCPs
```powershell
$config = Get-Content "$env:USERPROFILE\.config\opencode\opencode.json" | ConvertFrom-Json
$mcps = $config.mcp | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name
Write-Host "✅ MCPs configured:"
$mcps | ForEach-Object { Write-Host "  - $_" }
$expected = @("engram", "magic", "mcpollinations", "context7", "threejs", "heroui")
$missing = $expected | Where-Object { $_ -notin $mcps }
if ($missing) { Write-Host "❌ Missing MCPs: $($missing -join ', ')" } else { Write-Host "✅ All expected MCPs present" }
```

#### 7.3.5 SDD commands available
```powershell
Get-ChildItem "$env:USERPROFILE\.config\opencode\commands\sdd-*.md" | ForEach-Object { Write-Host "  📄 $($_.Name)" }
$sddCount = (Get-ChildItem "$env:USERPROFILE\.config\opencode\commands\sdd-*.md" | Measure-Object).Count
if ($sddCount -ge 7) { Write-Host "✅ SDD commands: $sddCount found" } else { Write-Host "❌ SDD commands: only $sddCount (expected 7+)" }
```

#### 7.3.6 Dependencies exist
```powershell
$checks = @(
    @{Name="sox"; Cmd="rec --version 2>&1"},
    @{Name="whisper-cpp"; Cmd="whisper-cpp --help 2>&1"},
    @{Name="ollama"; Cmd="ollama --version 2>&1"},
    @{Name="node"; Cmd="node --version"},
    @{Name="engram"; Cmd="engram version 2>&1"},
    @{Name="gentle-ai"; Cmd="gentle-ai version 2>&1"}
)
foreach ($c in $checks) {
    $result = Invoke-Expression $c.Cmd
    if ($LASTEXITCODE -eq 0) { Write-Host "✅ $($c.Name): OK" } else { Write-Host "❌ $($c.Name): NOT FOUND" }
}
```

### 7.4 Report status to user
```
🧪 END-TO-END VERIFICATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ / ❌ OpenCode installed
✅ / ❌ Config cloned from GitHub
✅ / ❌ System dependencies (sox, whisper-cpp, ollama, node, engram, gentle-ai)
✅ / ❌ ML models downloaded (whisper base, ollama qwen2.5)
✅ / ❌ API key configured (MAGIC_API_KEY)
✅ / ❌ opencode.json generated (all MCPs present)
✅ / ❌ Skill registry refreshed
✅ / ❌ Engram responds
✅ / ❌ Voice pipeline works
✅ / ❌ SDD commands available
```

If ALL are ✅ → proceed to Phase 8.
If any ❌ → fix that step before continuing.

---

## Phase 8: Final Instructions

Tell the user:
1. "OpenCode is ready. Press `Win+R`, type `opencode`, and press Enter."
2. "Apretá `ctrl+r` para usar el voice input."
3. "Decime `setup this machine` en la próxima máquina y repito todo esto."
