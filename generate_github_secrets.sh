#!/bin/bash

# GitHub Secrets Generator for KidsList
# This script generates the necessary secrets for GitHub Actions automated builds

set -e

echo "🔐 KidsList - GitHub Secrets Generator"
echo "======================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if we're in the Flutter project directory
if [ ! -f "pubspec.yaml" ]; then
    echo -e "${RED}❌ Error: Not in a Flutter project directory${NC}"
    echo "Please run this script from the root of your Flutter project"
    exit 1
fi

echo -e "${BLUE}📍 Project Directory: $(pwd)${NC}"
echo ""

# Check if keystore exists
if [ ! -f "android/release-key.jks" ]; then
    echo -e "${RED}❌ Error: android/release-key.jks not found!${NC}"
    echo ""
    echo "The release keystore file is missing. This is required for signing Android builds."
    echo ""
    echo "If you need to create a new keystore, run:"
    echo "  keytool -genkey -v -keystore android/release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias release"
    echo ""
    exit 1
fi

# Check if key.properties exists
if [ ! -f "android/key.properties" ]; then
    echo -e "${RED}❌ Error: android/key.properties not found!${NC}"
    echo ""
    echo "The key.properties file is missing. This file contains keystore credentials."
    echo ""
    exit 1
fi

echo -e "${GREEN}✅ Found required files:${NC}"
echo "  - android/release-key.jks"
echo "  - android/key.properties"
echo ""

# Create output directory
mkdir -p .github-secrets
OUTPUT_DIR=".github-secrets"

echo -e "${YELLOW}🔄 Generating secrets...${NC}"
echo ""

# Generate KEYSTORE_BASE64
echo -e "${BLUE}1/2 Generating KEYSTORE_BASE64...${NC}"
KEYSTORE_BASE64=$(base64 android/release-key.jks | tr -d '\n')
echo "$KEYSTORE_BASE64" > "$OUTPUT_DIR/KEYSTORE_BASE64.txt"
echo -e "    ${GREEN}✅ Saved to: $OUTPUT_DIR/KEYSTORE_BASE64.txt${NC}"
echo ""

# Copy KEY_PROPERTIES
echo -e "${BLUE}2/2 Generating KEY_PROPERTIES...${NC}"
cp android/key.properties "$OUTPUT_DIR/KEY_PROPERTIES.txt"
echo -e "    ${GREEN}✅ Saved to: $OUTPUT_DIR/KEY_PROPERTIES.txt${NC}"
echo ""

echo -e "${GREEN}✅ Setup Complete!${NC}"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${YELLOW}📋 Next Steps:${NC}"
echo ""
echo "1. Go to your GitHub repository settings:"
echo -e "   ${BLUE}https://github.com/conreid-838/Activity-Directory/settings/secrets/actions${NC}"
echo ""
echo "2. Add the following secrets:"
echo ""
echo -e "   ${YELLOW}Secret Name:${NC} KEYSTORE_BASE64"
echo "   Secret Value: (Copy from $OUTPUT_DIR/KEYSTORE_BASE64.txt)"
echo ""
echo -e "   ${YELLOW}Secret Name:${NC} KEY_PROPERTIES"
echo "   Secret Value: (Copy from $OUTPUT_DIR/KEY_PROPERTIES.txt)"
echo ""
echo "3. To copy secrets to clipboard (if xclip is installed):"
echo "   cat $OUTPUT_DIR/KEYSTORE_BASE64.txt | xclip -selection clipboard"
echo "   cat $OUTPUT_DIR/KEY_PROPERTIES.txt | xclip -selection clipboard"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${RED}⚠️  SECURITY WARNING:${NC}"
echo ""
echo "- Keep the $OUTPUT_DIR directory secure and do NOT commit it to Git"
echo "- The .gitignore already excludes this directory"
echo "- Delete these files after uploading secrets to GitHub"
echo "- Store original keystore files in a secure location (password manager, encrypted storage)"
echo ""
echo "To delete generated secrets after upload:"
echo -e "  ${YELLOW}rm -rf $OUTPUT_DIR${NC}"
echo ""

# Display file sizes
echo -e "${BLUE}📊 Secret Sizes:${NC}"
KEYSTORE_SIZE=$(wc -c < "$OUTPUT_DIR/KEYSTORE_BASE64.txt")
PROPERTIES_SIZE=$(wc -c < "$OUTPUT_DIR/KEY_PROPERTIES.txt")
echo "  - KEYSTORE_BASE64: $KEYSTORE_SIZE bytes"
echo "  - KEY_PROPERTIES: $PROPERTIES_SIZE bytes"
echo ""

echo -e "${GREEN}🚀 Ready for automated builds!${NC}"
echo ""
