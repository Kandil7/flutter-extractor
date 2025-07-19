#!/bin/bash
# Flutter Code Extractor CLI - Local installer
# For installing from local repository/development
set -e

TOOL_NAME="flutter-extractor"
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
    echo -e "${PURPLE}│      Flutter Code Extractor CLI        │${NC}"
    echo -e "${PURPLE}│         Local Installer v$VERSION         │${NC}"
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

# Function to check if we're in the right directory
check_repository() {
    if [[ ! -f "$TOOL_NAME" ]]; then
        print_error "flutter-extractor executable not found in current directory"
        print_error "Please run this script from the repository root directory"
        print_status "Expected file structure:"
        echo "  flutter-extractor/"
        echo "  ├── flutter-extractor     (main executable)"
        echo "  ├── install.sh           (remote installer)"
        echo "  ├── install_local.sh     (this script)"
        echo "  └── README.md"
        exit 1
    fi
}

# Function to make executable if it isn't already
ensure_executable() {
    if [[ ! -x "$TOOL_NAME" ]]; then
        print_status "Making $TOOL_NAME executable..."
        chmod +x "$TOOL_NAME"
    fi
}

# Function to determine installation directory
get_install_dir() {
    # Check if ~/.local/bin is in PATH and writable
    if [[ ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
        echo "$HOME/.local/bin"
        return 0
    fi
    
    # Check if /usr/local/bin is writable and in PATH
    if [[ -w "/usr/local/bin" ]] && [[ ":$PATH:" == *":/usr/local/bin:"* ]]; then
        echo "/usr/local/bin"
        return 0
    fi
    
    # Check if /usr/local/bin is in PATH (may need sudo)
    if [[ ":$PATH:" == *":/usr/local/bin:"* ]]; then
        echo "/usr/local/bin"
        export NEED_SUDO=true
        return 0
    fi
    
    # Default to ~/.local/bin
    mkdir -p "$HOME/.local/bin"
    echo "$HOME/.local/bin"
    export PATH_WARNING=true
    return 0
}

# Function to install the tool
install_tool() {
    local install_dir="$1"
    local target_path="$install_dir/$TOOL_NAME"
    
    print_status "Installing to: $target_path"
    
    # Remove existing installation if present
    if [[ -f "$target_path" ]]; then
        print_status "Removing existing installation..."
        if [[ "$NEED_SUDO" == true ]]; then
            sudo rm -f "$target_path"
        else
            rm -f "$target_path"
        fi
    fi
    
    # Copy the executable
    if [[ "$NEED_SUDO" == true ]]; then
        sudo cp "$TOOL_NAME" "$target_path"
        sudo chmod +x "$target_path"
    else
        cp "$TOOL_NAME" "$target_path"
        chmod +x "$target_path"
    fi
    
    print_success "Installed to: $target_path"
}

# Function to verify installation
verify_installation() {
    print_status "Verifying installation..."
    
    # Check if command is available
    if command -v "$TOOL_NAME" &> /dev/null; then
        print_success "Installation verified! ✓"
        
        # Try to get version info
        if "$TOOL_NAME" --version &> /dev/null; then
            local version_output=$("$TOOL_NAME" --version 2>&1)
            print_status "Version: $version_output"
        fi
        
        return 0
    else
        print_warning "Installation complete but '$TOOL_NAME' not found in PATH"
        return 1
    fi
}

# Function to show usage instructions
show_usage() {
    echo ""
    echo -e "${GREEN}Usage Examples:${NC}"
    echo "  $TOOL_NAME extract              # Extract current Flutter app"
    echo "  $TOOL_NAME extract -p -a        # Include pubspec.yaml and assets"
    echo "  $TOOL_NAME extract --help       # Show all options"
    echo "  $TOOL_NAME --version            # Show version"
    echo ""
}

# Function to show PATH setup instructions
show_path_setup() {
    if [[ "$PATH_WARNING" == true ]]; then
        print_warning "~/.local/bin is not in your PATH"
        print_status "Add this line to your shell configuration file:"
        echo ""
        echo -e "${YELLOW}  export PATH=\"\$HOME/.local/bin:\$PATH\"${NC}"
        echo ""
        print_status "Shell configuration files:"
        echo "  • Bash: ~/.bashrc or ~/.bash_profile"
        echo "  • Zsh: ~/.zshrc"
        echo "  • Fish: ~/.config/fish/config.fish"
        echo ""
        print_status "After adding the line, restart your terminal or run:"
        echo "  source ~/.bashrc  # (or your shell's config file)"
        echo ""
    fi
}

# Function to handle uninstallation
uninstall() {
    print_status "Uninstalling Flutter Code Extractor..."
    
    local removed_count=0
    local locations=(
        "$HOME/.local/bin/$TOOL_NAME"
        "/usr/local/bin/$TOOL_NAME"
        "/usr/bin/$TOOL_NAME"
    )
    
    for location in "${locations[@]}"; do
        if [[ -f "$location" ]]; then
            print_status "Removing: $location"
            if [[ "$location" == "/usr/local/bin/$TOOL_NAME" ]] || [[ "$location" == "/usr/bin/$TOOL_NAME" ]]; then
                sudo rm -f "$location"
            else
                rm -f "$location"
            fi
            ((removed_count++))
        fi
    done
    
    if [[ $removed_count -gt 0 ]]; then
        print_success "Uninstalled successfully! ($removed_count files removed)"
    else
        print_warning "No installation found"
    fi
    
    exit 0
}

# Function to show help
show_help() {
    print_header
    echo "Local installation script for Flutter Code Extractor CLI"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --uninstall    Remove installed flutter-extractor"
    echo "  --help, -h     Show this help message"
    echo "  --force        Force reinstallation even if already installed"
    echo ""
    echo "This script installs flutter-extractor from the local repository."
    echo "Run this script from the repository root directory."
    exit 0
}

# Main installation process
main() {
    # Parse command line arguments
    local force_install=false
    
    for arg in "$@"; do
        case $arg in
            --uninstall)
                uninstall
                ;;
            --help|-h)
                show_help
                ;;
            --force)
                force_install=true
                shift
                ;;
            *)
                print_error "Unknown option: $arg"
                echo "Use --help for usage information"
                exit 1
                ;;
        esac
    done
    
    print_header
    
    # Check if already installed (unless force is specified)
    if [[ "$force_install" != true ]] && command -v "$TOOL_NAME" &> /dev/null; then
        print_warning "$TOOL_NAME is already installed"
        print_status "Current installation: $(which $TOOL_NAME)"
        echo ""
        echo "Options:"
        echo "  • Use --force to reinstall"
        echo "  • Use --uninstall to remove"
        echo ""
        read -p "Continue with reinstallation? (y/N): " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_status "Installation cancelled"
            exit 0
        fi
        echo ""
    fi
    
    # Perform installation steps
    print_status "Starting local installation..."
    
    check_repository
    ensure_executable
    
    local install_dir
    install_dir=$(get_install_dir)
    
    install_tool "$install_dir"
    
    if verify_installation; then
        show_usage
        show_path_setup
        print_success "Flutter Code Extractor CLI installation complete!"
    else
        show_path_setup
        print_warning "Installation completed with warnings"
        print_status "You may need to restart your terminal or update your PATH"
    fi
}

# Run main function with all arguments
main "$@"
