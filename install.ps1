$ErrorActionPreference = "Stop"

$installDir = "$env:USERPROFILE\activity-logger"
$targetFile = Join-Path $installDir "logger.ps1"
$sourceUrl = "https://raw.githubusercontent.com/44103/activity-logger/main/logger.ps1"

if (-not (Test-Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir -Force | Out-Null
    Write-Host "Created directory: $installDir"
}

Invoke-WebRequest -Uri $sourceUrl -OutFile $targetFile
Write-Host "Installed logger.ps1 to $targetFile"
