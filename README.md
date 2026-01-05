# Activity Logger

A simple script to log the active window title and process name.

## Installation (Windows)

Run the following command in PowerShell to install the logger:

```powershell
irm https://raw.githubusercontent.com/44103/activity-logger/main/install.ps1 | iex
```

This script will:
1. Create the installation directory at `~\activity-logger`.
2. Download `logger.ps1` from the repository.

## Usage (Windows)

To start the logger manually, run:

```powershell
powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File "$env:USERPROFILE\activity-logger\logger.ps1"
```
