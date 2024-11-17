#!/bin/bash

REPO_URL="https://github.com/witetech/flipper/archive/main.tar.gz"
TARGET_DIR="$(pwd)"

error() {
    echo "[ERROR] $1" >&2
    exit 1
}

command -v curl >/dev/null 2>&1 || error "curl is not installed"
command -v tar >/dev/null 2>&1 || error "tar is not installed"

# Define list of files and folders to be merged
FILES_TO_MERGE=(".github" "test.asd")

echo "Downloading..."
TEMP_DIR=$(mktemp -d)
(
    cd "$TEMP_DIR"
    # Extract all files/folders from the archive
    curl -sL "$REPO_URL" | tar xz --strip-components=1 || error "Failed to extract files"
)

# Process each file/folder in FILES_TO_MERGE
for item in "${FILES_TO_MERGE[@]}"; do
    if [ -e "$TARGET_DIR/$item" ]; then
        echo "Replacing existing $item in $TARGET_DIR..."
    else
        echo "No existing $item found. Creating it in $TARGET_DIR..."
    fi

    # Ensure parent directory exists
    mkdir -p "$(dirname "$TARGET_DIR/$item")"
    
    # Copy the files/folders
    if [ -e "$TEMP_DIR/$item" ]; then
        rsync -a "$TEMP_DIR/$item/" "$TARGET_DIR/$item/" || error "Failed to merge $item into $TARGET_DIR"
    else
        error "Required item $item not found in downloaded content"
    fi
done

rm -rf "$TEMP_DIR"
echo "Setup completed successfully."
