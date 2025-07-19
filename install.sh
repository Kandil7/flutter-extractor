#!/bin/bash

# Flutter Code Extractor CLI - One-line installer
# curl -fsSL https://raw.githubusercontent.com/your-repo/flutter-extractor/main/install.sh | bash

set -e

TOOL_NAME="flutter-extractor"
REPO_URL="https://raw.githubusercontent.com/Kandil7/flutter-extractor/main/flutter-extractor"
VERSION="1.0.0"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
NC='\033[0m'

print_header() {
    echo -e "${PURPLE}╭─────────────────────────────────────────╮${NC}"
    echo -e "${PURPLE}│         Flutter Code Extractor         │${NC}"
    echo -e "${PURPLE}│             Installer v$VERSION            │${NC}"
    echo -e "${PURPLE}╰─────────────────────────────────────────╯${NC}"
    echo ""
}

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_header

# Determine installation directory
if [[ ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
    INSTALL_DIR="$HOME/.local/bin"
elif [[ -w "/usr/local/bin" ]] && [[ ":$PATH:" == *":/usr/local/bin:"* ]]; then
    INSTALL_DIR="/usr/local/bin"
elif [[ ":$PATH:" == *":/usr/local/bin:"* ]]; then
    INSTALL_DIR="/usr/local/bin"
    NEED_SUDO=true
else
    INSTALL_DIR="$HOME/.local/bin"
    mkdir -p "$INSTALL_DIR"
    print_warning "Created $INSTALL_DIR"
    print_status "Add this to your ~/.bashrc or ~/.zshrc:"
    echo "export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
fi

print_status "Installing Flutter Code Extractor CLI..."
print_status "Installation directory: $INSTALL_DIR"

# Download and install
if command -v curl &> /dev/null; then
    if [ "$NEED_SUDO" = true ]; then
        curl -fsSL "$REPO_URL" | sudo tee "$INSTALL_DIR/$TOOL_NAME" > /dev/null
        sudo chmod +x "$INSTALL_DIR/$TOOL_NAME"
    else
        curl -fsSL "$REPO_URL" -o "$INSTALL_DIR/$TOOL_NAME"
        chmod +x "$INSTALL_DIR/$TOOL_NAME"
    fi
elif command -v wget &> /dev/null; then
    if [ "$NEED_SUDO" = true ]; then
        sudo wget -O "$INSTALL_DIR/$TOOL_NAME" "$REPO_URL"
        sudo chmod +x "$INSTALL_DIR/$TOOL_NAME"
    else
        wget -O "$INSTALL_DIR/$TOOL_NAME" "$REPO_URL"
        chmod +x "$INSTALL_DIR/$TOOL_NAME"
    fi
else
    print_error "Neither curl nor wget is available"
    print_error "Please install curl or wget and try again"
    exit 1
fi

print_success "Installed to: $INSTALL_DIR/$TOOL_NAME"

# Verify installation
if command -v "$TOOL_NAME" &> /dev/null; then
    print_success "Installation verified!"
    echo ""
    print_status "You can now use the following commands:"
    echo "  $TOOL_NAME extract              # Extract current Flutter app"
    echo "  $TOOL_NAME extract -p -a        # Include pubspec.yaml and assets"
    echo "  $TOOL_NAME help                 # Show all options"
    echo ""
else
    print_warning "Installation complete but '$TOOL_NAME' not found in PATH"
    print_status "You may need to:"
    print_status "  1. Restart your terminal"
    print_status "  2. Run: source ~/.bashrc (or ~/.zshrc)"
    print_status "  3. Add $INSTALL_DIR to your PATH"
fi

print_success "Flutter Code Extractor CLI installation complete!"
