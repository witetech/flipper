#!/bin/bash

# Repository URL
REPO_URL="https://github.com/witetech/flipper/archive/main.tar.gz"

# Target directory
TARGET_DIR="$(pwd)"

# Check if curl is installed
command -v curl >/dev/null 2>&1 || { echo "curl is not installed" && exit 1; }

# Check if tar is installed
command -v tar >/dev/null 2>&1 || { echo "tar is not installed" && exit 1; }

# Check if rsync is installed
command -v rsync >/dev/null 2>&1 || { echo "rsync is not installed" && exit 1; }

# Define list of files and folders to be merged
FILES=(".github/" "analysis_options.yaml")

# Create the temporary directory
TEMP_DIR=$(mktemp -d)

# Download the repository to the temporary directory
curl -sL "$REPO_URL" | tar xz --strip-components=1 -C "$TEMP_DIR" || { echo "Failed to download the repository" && exit 1; }

# Loop through the files and folders to be merged and merge them
for FILE in "${FILES[@]}"; do
    # Ensure parent directory exists
    mkdir -p "$(dirname "$TARGET_DIR/$FILE")"

    # Copy the files/folders using rsync
    rsync -a "$TEMP_DIR/$FILE" "$TARGET_DIR/$FILE" || { echo "Failed to merge $FILE into $TARGET_DIR" && exit 1; }
done

# Remove the temporary directory
rm -rf "$TEMP_DIR"
