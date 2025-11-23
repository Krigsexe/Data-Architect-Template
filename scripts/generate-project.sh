#!/bin/bash
# Interactive wizard to fill placeholders in the master template

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}"
echo "================================================================"
echo "  Data Architect Template - Project Generator"
echo "================================================================"
echo -e "${NC}"

# Prompt function
prompt() {
    local var_name="$1"
    local prompt_text="$2"
    local default="$3"
    
    if [ -n "$default" ]; then
        read -p "$prompt_text [$default]: " value
        value="${value:-$default}"
    else
        read -p "$prompt_text: " value
    fi
    
    eval "$var_name='$value'"
}

echo -e "${YELLOW}Let's configure your project...${NC}"
echo ""

# Project Identity
echo -e "${GREEN}=== Project Identity ===${NC}"
prompt PROJECT_NAME "Project Name (e.g., Klaro, DataFlow)"
prompt DOMAIN_DESCRIPTION "Domain Description (e.g., intelligent triage, AI CRM)" "intelligent automation"
prompt DESCRIPTION_TYPE "Solution Type" "all-in-one"
prompt TAGLINE_SHORT "Short Tagline (max 60 chars)" "AI-powered automation platform"

# Convert to lowercase for IDs
PROJECT_ID_LOWERCASE="${PROJECT_NAME,,}"
PROJECT_ID_LOWER="${PROJECT_NAME,,}"
PROJECT_ID_UPPER="${PROJECT_NAME^^}"

echo ""

# Developer Info
echo -e "${GREEN}=== Developer Information ===${NC}"
prompt DEVELOPER_NAME "Your Name" "Developer"
prompt GITHUB_USER "GitHub Username"
prompt DEVELOPER_TAGLINE "Your Tagline" "Make With Passion"

echo ""

# Technical Stack
echo -e "${GREEN}=== Technical Stack ===${NC}"
prompt BACKEND_FRAMEWORK "Backend Framework" "Fastify"
prompt FRONTEND_FRAMEWORK "Frontend Framework" "React 18+"
prompt ORM_CHOICE "ORM Choice" "Prisma"
prompt BUILD_TOOL "Build Tool" "Vite"
prompt PACKAGE_MANAGER "Package Manager" "npm"

echo ""

# Configuration
echo -e "${GREEN}=== Configuration ===${NC}"
prompt PRIMARY_LANGUAGE "Primary Language (FR/EN/DE/ES)" "EN"
prompt APP_PORT "Application Port" "3000"
prompt DEFAULT_CONFIDENCE_THRESHOLD "Default Confidence Threshold (0-100)" "80"
prompt NUM_AGENTS "Number of AI Agents" "5"
prompt NUM_CONNECTORS "Number of Connectors" "10"

echo ""
echo -e "${GREEN}=== Generating your customized template ===${NC}"

# Create output directory
OUTPUT_DIR="./generated-projects"
mkdir -p "$OUTPUT_DIR"

OUTPUT_FILE="$OUTPUT_DIR/${PROJECT_ID_LOWERCASE}-template.md"

# Copy master template
cp templates/master-template.md "$OUTPUT_FILE"

# Replace placeholders
sed -i "
    s/\[PROJECT_NAME\]/$PROJECT_NAME/g;
    s/\[PROJECT_ID_LOWERCASE\]/$PROJECT_ID_LOWERCASE/g;
    s/\[PROJECT_NAME_LOWER\]/$PROJECT_ID_LOWER/g;
    s/\[PROJECT_ID_UPPER\]/$PROJECT_ID_UPPER/g;
    s/\[DOMAIN_DESCRIPTION\]/$DOMAIN_DESCRIPTION/g;
    s/\[DESCRIPTION_TYPE\]/$DESCRIPTION_TYPE/g;
    s/\[TAGLINE_SHORT\]/$TAGLINE_SHORT/g;
    s/\[DEVELOPER_NAME\]/$DEVELOPER_NAME/g;
    s/\[GITHUB_USER\]/$GITHUB_USER/g;
    s/\[DEVELOPER_TAGLINE\]/$DEVELOPER_TAGLINE/g;
    s/\[BACKEND_FRAMEWORK\]/$BACKEND_FRAMEWORK/g;
    s/\[FRONTEND_FRAMEWORK\]/$FRONTEND_FRAMEWORK/g;
    s/\[ORM_CHOICE\]/$ORM_CHOICE/g;
    s/\[BUILD_TOOL\]/$BUILD_TOOL/g;
    s/\[PACKAGE_MANAGER\]/$PACKAGE_MANAGER/g;
    s/\[PRIMARY_LANGUAGE\]/$PRIMARY_LANGUAGE/g;
    s/\[APP_PORT\]/$APP_PORT/g;
    s/\[DEFAULT_CONFIDENCE_THRESHOLD\]/$DEFAULT_CONFIDENCE_THRESHOLD/g;
    s/\[NUM_AGENTS\]/$NUM_AGENTS/g;
    s/\[NUM_CONNECTORS\]/$NUM_CONNECTORS/g;
" "$OUTPUT_FILE"

echo ""
echo -e "${GREEN}✅ Template generated successfully!${NC}"
echo ""
echo "Output file: $OUTPUT_FILE"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Review and customize the generated template"
echo "2. Run validation: ./scripts/validate-placeholders.sh $OUTPUT_FILE"
echo "3. Use with Claude Code to generate your complete project"
echo ""
echo -e "${BLUE}Happy coding! 🚀${NC}"
