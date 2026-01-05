#!/bin/bash

LOG_DIR="$HOME/activity-logger/logs"
mkdir -p "$LOG_DIR"

CURRENT_DATE=""
LOG_FILE=""
LAST_PROCESS_NAME=""
LAST_WINDOW_TITLE=""

while true; do
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
    DATE=$(date "+%Y-%m-%d")

    # 日付が変わったらログファイルを切り替え
    if [ "$DATE" != "$CURRENT_DATE" ]; then
        CURRENT_DATE="$DATE"
        LOG_FILE="$LOG_DIR/$CURRENT_DATE.csv"
        if [ ! -f "$LOG_FILE" ]; then
            echo "DateTime,ProcessName,WindowTitle" > "$LOG_FILE"
        fi
    fi

    # AppleScript でアクティブなウィンドウ情報を取得
    # 1行目: プロセス名, 2行目: ウィンドウタイトル
    INFO=$(osascript -e '
        tell application "System Events"
            set frontApp to first application process whose frontmost is true
            set frontAppName to name of frontApp
            set windowTitle to ""
            try
                tell process frontAppName
                    set windowTitle to name of front window
                end tell
            end try
            return frontAppName & "\n" & windowTitle
        end tell
    ' 2>/dev/null)

    if [ $? -eq 0 ]; then
        PROCESS_NAME=$(echo "$INFO" | head -n 1)
        WINDOW_TITLE=$(echo "$INFO" | tail -n +2)
    else
        PROCESS_NAME="Error"
        WINDOW_TITLE="Failed to get window title"
    fi

    if [ "$PROCESS_NAME" != "$LAST_PROCESS_NAME" ] || [ "$WINDOW_TITLE" != "$LAST_WINDOW_TITLE" ]; then
        # CSV出力
        echo "$TIMESTAMP,$PROCESS_NAME,$WINDOW_TITLE" >> "$LOG_FILE"
        echo "$TIMESTAMP - $PROCESS_NAME - $WINDOW_TITLE"

        LAST_PROCESS_NAME="$PROCESS_NAME"
        LAST_WINDOW_TITLE="$WINDOW_TITLE"
    fi

    sleep 60
done
