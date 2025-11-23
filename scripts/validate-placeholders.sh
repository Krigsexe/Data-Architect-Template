#!/bin/bash
# Validate that all essential placeholders are filled in the template

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [ $# -eq 0 ]; then
    echo "Usage: $0 <template-file.md>"
    exit 1
fi

TEMPLATE_FILE="$1"

if [ ! -f "$TEMPLATE_FILE" ]; then
    echo -e "${RED}Error: File $TEMPLATE_FILE not found${NC}"
    exit 1
fi

echo "Validating placeholders in: $TEMPLATE_FILE"
echo ""

# List of essential placeholders
ESSENTIAL_PLACEHOLDERS=(
    "PROJECT_NAME"
    "DEVELOPER_NAME"
    "GITHUB_USER"
    "BACKEND_FRAMEWORK"
    "FRONTEND_FRAMEWORK"
    "ORM_CHOICE"
    "PRIMARY_LANGUAGE"
    "APP_PORT"
)

MISSING_COUNT=0
FILLED_COUNT=0

echo -e "${YELLOW}Checking essential placeholders...${NC}"
echo ""

for placeholder in "${ESSENTIAL_PLACEHOLDERS[@]}"; do
    if grep -q "\[$placeholder\]" "$TEMPLATE_FILE"; then
        echo -e "${RED}❌ Missing: [$placeholder]${NC}"
        MISSING_COUNT=$((MISSING_COUNT + 1))
    else
        echo -e "${GREEN}✅ Filled: $placeholder${NC}"
        FILLED_COUNT=$((FILLED_COUNT + 1))
    fi
done

echo ""
echo "Summary:"
echo -e "${GREEN}Filled: $FILLED_COUNT${NC}"
echo -e "${RED}Missing: $MISSING_COUNT${NC}"
echo ""

if [ $MISSING_COUNT -gt 0 ]; then
    echo -e "${RED}Validation failed. Please fill all essential placeholders before generating.${NC}"
    exit 1
else
    echo -e "${GREEN}All essential placeholders are filled! ✅${NC}"
    echo "You can now proceed with Claude Code generation."
    exit 0
fi