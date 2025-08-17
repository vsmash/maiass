# Installation Guide

## Prerequisites

### Operating System Requirements
- **macOS, Linux, or Windows with WSL**
- **Shell:** Bash 3.2 or later (macOS default bash supported)
- **Git:** Git command-line tools installed
- **jq:** JSON processor (required for AI features)
- **Optional:** OpenAI API key for AI features

### Platform Compatibility

**Unix/Linux/macOS Only** - This is a bash script that requires:
- Bash shell (version 3.2+ - compatible with macOS default bash)
- Unix-like environment (macOS, Linux, WSL)
- Git command-line tools
- **jq** - JSON processor (required for AI features)
- Standard Unix utilities (`grep`, `sed`, `awk`, etc.)
- Unicode support for display characters (ℹ, ✓, ⚠, etc.)

**⚠️ Windows Compatibility Warning:**
- **Not tested on Windows** - This script has not been tested in Windows environments
- **Unicode Issues** - Uses Unicode characters that may not display correctly in Windows Command Prompt or PowerShell
- **Bash Dependency** - Requires bash shell, not available natively on Windows
- **Recommended Solution** - Windows users should use WSL (Windows Subsystem for Linux) or Git Bash

## Installing Dependencies

### Installing jq

```bash
# macOS
brew install jq

# Ubuntu/Debian (including Raspberry Pi)
sudo apt install jq

# CentOS/RHEL/Fedora
sudo yum install jq
# or on newer versions:
sudo dnf install jq

# Alpine Linux
sudo apk add jq
```

## Installation Methods

### Option 1: Homebrew (Recommended)

```bash
# Add the tap
brew tap vsmash/homebrew-maiass

# Install maiass
brew install maiass
```

### Option 2: Manual Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/vsmash/maiass.git
   cd maiass
   ```

2. **Run the installer:**
   ```bash
   ./install.sh
   ```
   - This will install both `maiass.sh` (symlinked as `maiass`, `myass`, and `miass`) and, if present, `committhis.sh` (symlinked as `committhis`) to your `~/.local/bin` directory.

3. **Restart your terminal** or source your shell profile:
   ```bash
   source ~/.zshrc  # or ~/.bashrc
   ```

4. **Windows users:** Use WSL (Windows Subsystem for Linux) or Git Bash

## Verification

After installation, verify MAIASS and AI Commit are working:

```bash
# Check if maiass is available
maiass --help

# Check if committhis is available (if committhis.sh present)
committhis --help

# Test in a git repository
cd /path/to/your/git/repo
maiass --help
```

## Next Steps

- See [Configuration](configuration.md) for setting up your environment
- See [AI Integration](ai-integration.md) for OpenAI setup
- See [Quick Start](#) in the main README for basic usage
