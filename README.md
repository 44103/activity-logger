# Activity Logger

A simple script to log the active window title and process name.

## Installation

This script will create the installation directory (`~/activity-logger`) and download the appropriate logger script.

### Windows (PowerShell)
Run the following command in PowerShell to install the logger:
```powershell
irm https://raw.githubusercontent.com/44103/activity-logger/main/install.ps1 | iex
```

### macOS (bash)
Run the following command in your terminal to install the logger:
```bash
curl -sL https://raw.githubusercontent.com/44103/activity-logger/main/install.sh | bash
```

## Usage

This will start the logger process in the background. Logs are saved to the `logs` subdirectory within the installation folder.

### Windows (PowerShell)

```powershell
powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File "$env:USERPROFILE\activity-logger\logger.ps1"
```

### macOS (bash)

```bash
~/activity-logger/logger.sh
```
