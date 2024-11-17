#!/bin/bash

REPO_URL="https://github.com/witetech/flipper/archive/main.tar.gz"
TARGET_DIR="$(pwd)"

error() {
    echo "[ERROR] $1" >&2
    exit 1
}

command -v curl >/dev/null 2>&1 || error "curl is not installed"
command -v tar >/dev/null 2>&1 || error "tar is not installed"

echo "Downloading..."
TEMP_DIR=$(mktemp -d)
(
    cd "$TEMP_DIR"
    curl -sL "$REPO_URL" | tar xz --strip-components=1 flipper-main/.github || error "Failed to extract the .github folder"
)

if [ -d "$TARGET_DIR/.github" ]; then
    echo "Replacing existing .github folder in $TARGET_DIR..."
else
    echo "No existing .github folder found. Creating one in $TARGET_DIR..."
fi

rsync -a --delete "$TEMP_DIR/.github/" "$TARGET_DIR/.github/" || error "Failed to sync the .github folder to $TARGET_DIR."

rm -rf "$TEMP_DIR"
echo "Setup completed successfully."
