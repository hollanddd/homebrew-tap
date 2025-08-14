#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

CONFIG_FILE="update-config.json"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo -e "${RED}Error: jq is required but not installed. Install with: brew install jq${NC}"
    exit 1
fi

# Check if config file exists
if [[ ! -f "$SCRIPT_DIR/$CONFIG_FILE" ]]; then
    echo -e "${RED}Error: Configuration file $CONFIG_FILE not found${NC}"
    exit 1
fi

# Read configuration
OWNER=$(jq -r '.github.owner' "$SCRIPT_DIR/$CONFIG_FILE")
REPO=$(jq -r '.github.repo' "$SCRIPT_DIR/$CONFIG_FILE")
FORMULA_FILE=$(jq -r '.formula.file' "$SCRIPT_DIR/$CONFIG_FILE")
URL_TEMPLATE=$(jq -r '.archive.url_template' "$SCRIPT_DIR/$CONFIG_FILE")

echo -e "${YELLOW}Fetching latest release for $OWNER/$REPO...${NC}"

# Get the latest release tag from GitHub API
LATEST_TAG=$(curl -s "https://api.github.com/repos/$OWNER/$REPO/releases/latest" | jq -r '.tag_name')

if [[ "$LATEST_TAG" == "null" || -z "$LATEST_TAG" ]]; then
    echo -e "${RED}Error: Could not fetch latest release tag${NC}"
    exit 1
fi

echo -e "${GREEN}Found latest release: $LATEST_TAG${NC}"

# Generate the download URL
DOWNLOAD_URL=$(echo "$URL_TEMPLATE" | sed "s/{owner}/$OWNER/g" | sed "s/{repo}/$REPO/g" | sed "s/{tag}/$LATEST_TAG/g")

echo -e "${YELLOW}Downloading and calculating SHA256 for $DOWNLOAD_URL...${NC}"

# Calculate SHA256 of the tarball
SHA256=$(curl -sL "$DOWNLOAD_URL" | shasum -a 256 | cut -d' ' -f1)

if [[ -z "$SHA256" ]]; then
    echo -e "${RED}Error: Could not calculate SHA256${NC}"
    exit 1
fi

echo -e "${GREEN}SHA256: $SHA256${NC}"

# Check if formula file exists
FORMULA_PATH="$SCRIPT_DIR/$FORMULA_FILE"
if [[ ! -f "$FORMULA_PATH" ]]; then
    echo -e "${RED}Error: Formula file $FORMULA_FILE not found${NC}"
    exit 1
fi

echo -e "${YELLOW}Updating formula file...${NC}"

# Create a backup
cp "$FORMULA_PATH" "$FORMULA_PATH.backup"

# Update the URL line
sed -i.tmp "s|url \".*\"|url \"$DOWNLOAD_URL\"|" "$FORMULA_PATH"

# Update the SHA256 line
sed -i.tmp "s|sha256 \".*\"|sha256 \"$SHA256\"|" "$FORMULA_PATH"

# Clean up temporary file
rm "$FORMULA_PATH.tmp"

echo -e "${GREEN}✓ Formula updated successfully!${NC}"
echo -e "  Release: $LATEST_TAG"
echo -e "  URL: $DOWNLOAD_URL"
echo -e "  SHA256: $SHA256"
echo -e ""
echo -e "${YELLOW}Please review the changes and test the formula:${NC}"
echo -e "  ruby -c $FORMULA_FILE"
echo -e "  brew install --build-from-source ./$FORMULA_FILE"
echo -e ""
echo -e "Backup saved as: $FORMULA_FILE.backup"