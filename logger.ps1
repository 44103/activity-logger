Add-Type @'
using System;
using System.Runtime.InteropServices;
using System.Text;
using System.Diagnostics;

public class Win32Api {
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
    [DllImport("user32.dll")]
    public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);
    [DllImport("user32.dll")]
    public static extern int GetWindowText(IntPtr hWnd, StringBuilder text, int count);
}
'@

$logDir = "logs"
if (-not (Test-Path $logDir)) {
    New-Item -ItemType Directory -Path $logDir | Out-Null
}

$currentDate = ""
$logFile = ""
$lastProcessName = ""
$lastWindowTitle = ""

while ($true) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $date = Get-Date -Format "yyyy-MM-dd"

    if ($date -ne $currentDate) {
        $currentDate = $date
        $logFile = Join-Path $logDir "$currentDate.csv"
        if (-not (Test-Path $logFile)) {
            "DateTime,ProcessName,WindowTitle" | Out-File -FilePath $logFile -Encoding UTF8
        }
    }

    try {
        $hWnd = [Win32Api]::GetForegroundWindow()
        $processId = 0
        [void][Win32Api]::GetWindowThreadProcessId($hWnd, [ref]$processId)

        $title = New-Object System.Text.StringBuilder 256
        [void][Win32Api]::GetWindowText($hWnd, $title, 256)

        $process = Get-Process -Id $processId -ErrorAction SilentlyContinue
        $processName = if ($process) { $process.ProcessName } else { "Unknown" }
        $windowTitle = $title.ToString()
    } catch {
        $processName = "Error"
        $windowTitle = "Failed to get window title"
    }

    if ($processName -ne $lastProcessName -or $windowTitle -ne $lastWindowTitle) {
        "$timestamp,$processName,$windowTitle" | Out-File -FilePath $logFile -Append -Encoding UTF8
        Write-Host "$timestamp - $processName - $windowTitle"

        $lastProcessName = $processName
        $lastWindowTitle = $windowTitle
    }

    Start-Sleep -Seconds 60
}
