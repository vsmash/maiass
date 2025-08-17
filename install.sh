#!/bin/bash

# MAIASS Installation Script v5.8.7
# Installs maiass.sh to a system location and creates a symlink in PATH
# use brew if osx or this for linux
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Installation directories
INSTALL_DIR="$HOME/.local/bin"
SCRIPT_NAME="maiass"
SCRIPT_FILE="maiass.sh"

# committhis install variables
committhis_SCRIPT_NAME="committhis.sh"
committhis_SYMLINK="committhis"

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

check_requirements() {
    print_info "Checking system requirements..."

    # Check if we're on a Unix-like system
    if [[ "$OSTYPE" != "darwin"* && "$OSTYPE" != "linux"* ]]; then
        print_error "This script requires macOS or Linux"
        exit 1
    fi

    # Check if bash is available
    if ! command -v bash >/dev/null 2>&1; then
        print_error "Bash is required but not found"
        exit 1
    fi

    # Check if git is available
    if ! command -v git >/dev/null 2>&1; then
        print_error "Git is required but not found"
        exit 1
    fi

    # Check if jq is available (required for AI features)
    if ! command -v jq >/dev/null 2>&1; then
        print_error "jq is required but not found"
        print_info "Install jq using your package manager:"
        print_info "  • macOS: brew install jq"
        print_info "  • Ubuntu/Debian: sudo apt-get install jq"
        print_info "  • CentOS/RHEL: sudo yum install jq"
        print_info "  • Raspberry Pi: sudo apt install jq"
        exit 1
    fi

    print_success "System requirements met"
}

create_install_directory() {
    if [[ ! -d "$INSTALL_DIR" ]]; then
        print_info "Creating installation directory: $INSTALL_DIR"
        mkdir -p "$INSTALL_DIR"
        print_success "Created $INSTALL_DIR"
    else
        print_info "Installation directory exists: $INSTALL_DIR"
    fi
}

install_script() {
    if [[ ! -f "$SCRIPT_FILE" ]]; then
        print_error "Cannot find $SCRIPT_FILE in current directory"
        print_info "Please run this installer from the maiass repository directory"
        exit 1
    fi

    print_info "Installing $SCRIPT_FILE to $INSTALL_DIR/$SCRIPT_NAME"

    # Copy script to install directory
    cp "$SCRIPT_FILE" "$INSTALL_DIR/$SCRIPT_NAME"

    # create symlink in install dir for myass because it's easier to type
    ln -sf "$INSTALL_DIR/$SCRIPT_NAME" "$INSTALL_DIR/myass"
    ln -sf "$INSTALL_DIR/$SCRIPT_NAME" "$INSTALL_DIR/miass"
    # Make executable
    chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

    print_success "Installed $SCRIPT_NAME to $INSTALL_DIR"

    # --- committhis.sh install ---
    if [[ -f "$committhis_SCRIPT_NAME" ]]; then
        print_info "Installing $committhis_SCRIPT_NAME to $INSTALL_DIR/$committhis_SCRIPT_NAME"
        cp "$committhis_SCRIPT_NAME" "$INSTALL_DIR/$committhis_SCRIPT_NAME"
        chmod +x "$INSTALL_DIR/$committhis_SCRIPT_NAME"
        ln -sf "$INSTALL_DIR/$committhis_SCRIPT_NAME" "$INSTALL_DIR/$committhis_SYMLINK"
        print_success "Installed $committhis_SCRIPT_NAME and symlinked as $committhis_SYMLINK"
    else
        print_warning "$committhis_SCRIPT_NAME not found in current directory, skipping install."
    fi
}

setup_path() {
    # Check if ~/.local/bin is in PATH
    if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
        print_warning "$INSTALL_DIR is not in your PATH"
        print_info "Adding $INSTALL_DIR to PATH in your shell profile"

        # Determine shell profile file
        if [[ "$SHELL" == *"zsh"* ]]; then
            PROFILE_FILE="$HOME/.zshrc"
        elif [[ "$SHELL" == *"bash"* ]]; then
            if [[ -f "$HOME/.bash_profile" ]]; then
                PROFILE_FILE="$HOME/.bash_profile"
            else
                PROFILE_FILE="$HOME/.bashrc"
            fi
        else
            print_warning "Unknown shell: $SHELL"
            print_info "Please manually add $INSTALL_DIR to your PATH"
            return
        fi

        # Add to PATH if not already there
        if [[ -f "$PROFILE_FILE" ]] && grep -q "$INSTALL_DIR" "$PROFILE_FILE"; then
            print_info "PATH already configured in $PROFILE_FILE"
        else
            echo "" >> "$PROFILE_FILE"
            echo "# Added by MAIASS installer" >> "$PROFILE_FILE"
            echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$PROFILE_FILE"
            print_success "Added $INSTALL_DIR to PATH in $PROFILE_FILE"
            print_warning "Please restart your terminal or run: source $PROFILE_FILE"
        fi
    else
        print_success "$INSTALL_DIR is already in your PATH"
    fi
}

verify_installation() {
    print_info "Verifying installation..."

    if [[ -x "$INSTALL_DIR/$SCRIPT_NAME" ]]; then
        print_success "MAIASS installed successfully!"
        print_info "Version: $($INSTALL_DIR/$SCRIPT_NAME --version 2>/dev/null || echo 'Unknown')"
        print_info "Location: $INSTALL_DIR/$SCRIPT_NAME"

        if command -v "$SCRIPT_NAME" >/dev/null 2>&1; then
            print_success "MAIASS is available in your PATH"
            print_info "You can now use: $SCRIPT_NAME"
        else
            print_warning "MAIASS is not yet available in your PATH"
            print_info "Please restart your terminal or run: source ~/.zshrc (or ~/.bashrc)"
        fi
    else
        print_error "Installation verification failed"
        exit 1
    fi
}

show_usage() {
    echo
    print_info "🚀 MAIASS is now installed!"
    echo
    echo "Basic usage:"
    echo "  $SCRIPT_NAME              # Bump patch version"
    echo "  $SCRIPT_NAME minor        # Bump minor version"
    echo "  $SCRIPT_NAME major        # Bump major version"
    echo "  $SCRIPT_NAME 2.1.0        # Set specific version"
    echo "  $SCRIPT_NAME --help       # Show help"
    echo
    echo "For AI-powered commit messages, set up your OpenAI API key:"
    echo "  export MAIASS_AI_MODE='ask'"
    echo
    print_info "See the README.md for complete configuration options"
}

main() {
    echo -e "${BLUE}|)) MAIASS Installation Script${NC}"
    echo

    check_requirements
    create_install_directory
    install_script
    setup_path
    verify_installation
    show_usage
}

# Handle command line arguments
case "${1:-}" in
    --help|-h)
        echo "MAIASS Installation Script"
        echo
        echo "Usage: $0 [OPTIONS]"
        echo
        echo "Options:"
        echo "  --help, -h     Show this help message"
        echo "  --uninstall    Remove MAIASS from system"
        echo
        echo "This script installs MAIASS to ~/.local/bin and adds it to your PATH."
        exit 0
        ;;
    --uninstall)
        if [[ -f "$INSTALL_DIR/$SCRIPT_NAME" ]]; then
            print_info "Removing $INSTALL_DIR/$SCRIPT_NAME"
            rm -f "$INSTALL_DIR/$SCRIPT_NAME"
            print_success "MAIASS uninstalled"
        else
            print_warning "MAIASS not found at $INSTALL_DIR/$SCRIPT_NAME"
        fi
        exit 0
        ;;
    "")
        main
        ;;
    *)
        print_error "Unknown option: $1"
        print_info "Use --help for usage information"
        exit 1
        ;;
esac
