# OpenCode Dotfiles — AI Setup Plan

Execute this plan **phase by phase** when the user says "setup this machine",
"setup", "instalar en esta máquina", or equivalent.

> **Rule**: Ask the user before each phase unless they said "auto" or "automatic".
> **Rule**: After each phase, summarize what was done and ask: "Continue to next phase?"
> **Rule**: If something fails, explain the error, suggest a fix, and let the user resolve before retrying.

---

## Phase 0: Prerequisites

### 0.1 Detect OS
```powershell
[System.Environment]::OSVersion.VersionString
```

### 0.2 Verify git
```powershell
git --version
```
If not found: guide user to install from https://git-scm.com/downloads/win

### 0.3 Verify PowerShell version (5.1+)
```powershell
$PSVersionTable.PSVersion
```

### 0.4 Install scoop (if not present)
```powershell
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    irm get.scoop.sh | iex
}
```

### 0.5 Install Go (if not present) — needed for engram
```powershell
go version
```
If not found: guide user to install from https://go.dev/dl/ (default options are fine).
After install, close and reopen the terminal so PATH is updated.

---

## Phase 1: Install OpenCode

### 1.1 Install via scoop
```powershell
scoop install opencode
```
Or if the user prefers winget:
```powershell
winget install opencode
```

### 1.2 Verify installation
```powershell
opencode version
```

---

## Phase 2: Clone / Update Config

### 2.1 Clone the repository
```powershell
$configDir = "$env:USERPROFILE\.config\opencode"
if (Test-Path $configDir) {
    Write-Host "Config directory already exists."
    if (Test-Path "$configDir\.git") {
        Write-Host "It's a git repo. Run 'git pull' to update."
    } else {
        Write-Host "WARNING: Directory exists but is NOT a git repo."
        Write-Host "Back up any custom files, then delete the directory and clone fresh."
    }
} else {
    git clone <REPO_URL> $configDir
}
```

Replace `<REPO_URL>` with the actual GitHub URL. Ask the user if you don't know it.

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

---

## Phase 4: Download ML Models

### 4.1 Download whisper model
```powershell
mkdir -Force $env:USERPROFILE\.local\share\whisper-cpp
whisper-cpp -m download -M base
```
If the download fails, try again or suggest using a VPN.

### 4.2 Pull Ollama model
```powershell
ollama pull qwen2.5:0.5b
```
This downloads ~397 MB. It may take a few minutes.

### 4.3 Start and verify Ollama
> **Note**: `ollama serve` runs in the background. If ollama was already installed, it might already be running as a Windows service.
```powershell
ollama serve
```
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

### 7.1 Test each MCP endpoint
Start OpenCode and verify MCPs appear as enabled:
- engram
- magic
- mcpollinations
- context7
- threejs
- heroui

### 7.2 Test voice pipeline
```powershell
# Test recording
rec -q -r 16000 -c 1 -b 16 "$env:USERPROFILE\Desktop\test.wav" trim 0 3
# Test transcription
whisper-cpp -m base -f "$env:USERPROFILE\Desktop\test.wav"
```

### 7.3 Report status to user
- ✅ / ❌ OpenCode installed
- ✅ / ❌ Config cloned
- ✅ / ❌ System dependencies
- ✅ / ❌ ML models downloaded
- ✅ / ❌ API keys configured
- ✅ / ❌ opencode.json generated
- ✅ / ❌ MCPs responding

---

## Phase 8: Final Instructions

Tell the user:
1. "OpenCode is ready. Press `Win+R`, type `opencode`, and press Enter."
2. "Apretá `ctrl+r` para usar el voice input."
3. "Decime `setup this machine` en la próxima máquina y repito todo esto."
