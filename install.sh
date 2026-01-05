#!/bin/bash

INSTALL_DIR="$HOME/activity-logger"
TARGET_FILE="$INSTALL_DIR/logger.sh"
SOURCE_URL="https://raw.githubusercontent.com/44103/activity-logger/main/logger.sh"

if [ ! -d "$INSTALL_DIR" ]; then
    mkdir -p "$INSTALL_DIR"
    echo "Created directory: $INSTALL_DIR"
fi

curl -L "$SOURCE_URL" -o "$TARGET_FILE"
chmod +x "$TARGET_FILE"
echo "Installed logger.sh to $TARGET_FILE"
