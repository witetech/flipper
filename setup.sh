#!/bin/bash

REPO_URL="https://github.com/witetech/flipper/archive/main.tar.gz"
TARGET_DIR="$(pwd)"

error_exit() {
    echo "[ERROR] $1" >&2
    exit 1
}

command -v curl >/dev/null 2>&1 || error_exit "curl is not installed. Please install it and try again."
command -v tar >/dev/null 2>&1 || error_exit "tar is not installed. Please install it and try again."

echo "[INFO] Downloading and extracting .github from repository..."
TEMP_DIR=$(mktemp -d) || error_exit "Failed to create a temporary directory."
(
    cd "$TEMP_DIR" || error_exit "Failed to navigate to temporary directory."
    curl -sL "$REPO_URL" | tar xz --strip-components=1 flipper-main/.github || error_exit "Failed to extract the .github folder."
)

if [ -d "$TARGET_DIR/.github" ]; then
    echo "[INFO] Replacing existing .github folder in $TARGET_DIR..."
else
    echo "[INFO] No existing .github folder found. Creating one in $TARGET_DIR..."
fi

rm -rf "$TARGET_DIR/.github" || error_exit "Failed to remove existing .github folder."
mv "$TEMP_DIR/.github" "$TARGET_DIR/.github" || error_exit "Failed to move the .github folder to $TARGET_DIR."

rm -rf "$TEMP_DIR"
echo "[INFO] Setup completed successfully. .github folder is now in $TARGET_DIR."
