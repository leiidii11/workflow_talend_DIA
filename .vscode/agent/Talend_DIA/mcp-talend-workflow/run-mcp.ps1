Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$ProgressPreference = "SilentlyContinue"

$baseDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$runtimeDir = Join-Path $baseDir ".runtime"
$pythonHome = Join-Path $runtimeDir "python"
$pythonExe = Join-Path $pythonHome "python.exe"
$serverPy = Join-Path $baseDir "server.py"
$requirementsFile = Join-Path $baseDir "requirements.txt"
$stampFile = Join-Path $runtimeDir "requirements.sha256"

$pythonVersion = "3.12.10"
$pythonTag = "python-3.12.10-embed-amd64"
$pythonZipUrl = "https://www.python.org/ftp/python/$pythonVersion/$pythonTag.zip"

function Write-Stderr([string]$message) {
  [Console]::Error.WriteLine($message)
}

function Invoke-NativeSilent {
  param(
    [string]$FilePath,
    [string[]]$Arguments
  )

  & $FilePath @Arguments *> $null
  if ($LASTEXITCODE -ne 0) {
    throw "Echec commande: $FilePath $($Arguments -join ' ')"
  }
}

function Get-FileSha256Hex {
  param([string]$Path)
  return (Get-FileHash -Path $Path -Algorithm SHA256).Hash.ToLowerInvariant()
}

try {
  if (-not (Test-Path -LiteralPath $pythonExe)) {
    New-Item -ItemType Directory -Path $pythonHome -Force | Out-Null

    $zipPath = Join-Path $runtimeDir "$pythonTag.zip"
    New-Item -ItemType Directory -Path $runtimeDir -Force | Out-Null

    Invoke-WebRequest -Uri $pythonZipUrl -OutFile $zipPath -UseBasicParsing
    Expand-Archive -Path $zipPath -DestinationPath $pythonHome -Force
    Remove-Item -LiteralPath $zipPath -Force -ErrorAction SilentlyContinue

    $pthFile = Join-Path $pythonHome "python312._pth"
    if (Test-Path -LiteralPath $pthFile) {
      $pthContent = Get-Content -LiteralPath $pthFile
      $patched = $pthContent | ForEach-Object {
        if ($_ -match '^#import site$') { 'import site' } else { $_ }
      }
      Set-Content -LiteralPath $pthFile -Value $patched -Encoding ASCII
    }

    $getPipPath = Join-Path $runtimeDir "get-pip.py"
    Invoke-WebRequest -Uri "https://bootstrap.pypa.io/get-pip.py" -OutFile $getPipPath -UseBasicParsing
    Invoke-NativeSilent -FilePath $pythonExe -Arguments @($getPipPath, "--disable-pip-version-check", "--no-warn-script-location")
    Remove-Item -LiteralPath $getPipPath -Force -ErrorAction SilentlyContinue
  }

  $requirementsHash = Get-FileSha256Hex -Path $requirementsFile
  $needInstall = $true

  if (Test-Path -LiteralPath $stampFile) {
    $current = (Get-Content -LiteralPath $stampFile -Raw).Trim().ToLowerInvariant()
    if ($current -eq $requirementsHash) {
      $needInstall = $false
    }
  }

  if ($needInstall) {
    Invoke-NativeSilent -FilePath $pythonExe -Arguments @("-m", "pip", "install", "--disable-pip-version-check", "--no-warn-script-location", "-r", $requirementsFile)
    Set-Content -LiteralPath $stampFile -Value $requirementsHash -Encoding ASCII
  }

  # IMPORTANT: no stdout before server starts (MCP stdio protocol).
  & $pythonExe $serverPy
  exit $LASTEXITCODE
}
catch {
  Write-Stderr "[mcp-talend-workflow] Bootstrap error: $($_.Exception.Message)"
  exit 1
}
