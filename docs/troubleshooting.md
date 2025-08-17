# Troubleshooting Guide

## Common Issues

### Installation Problems

#### "maiass: command not found"
**Symptoms**: Terminal doesn't recognize `maiass` command after installation.

**Solutions**:
1. **Restart your terminal** or open a new terminal window
2. **Source your shell profile**:
   ```bash
   source ~/.zshrc    # for zsh users
   source ~/.bashrc   # for bash users
   ```
3. **Check if MAIASS is in PATH**:
   ```bash
   which maiass
   echo $PATH
   ```
4. **Reinstall if necessary**:
   ```bash
   # Homebrew
   brew uninstall maiass && brew install maiass
   
   # Manual
   cd maiass && ./install.sh
   ```

#### "jq: command not found"
**Symptoms**: Error when MAIASS tries to process JSON files or AI features.

**Solutions**:
```bash
# macOS
brew install jq

# Ubuntu/Debian
sudo apt install jq

# CentOS/RHEL/Fedora
sudo yum install jq
# or newer versions:
sudo dnf install jq

# Alpine Linux
sudo apk add jq
```

#### Permission denied errors
**Symptoms**: Cannot execute MAIASS or write to files.

**Solutions**:
1. **Check file permissions**:
   ```bash
   ls -la $(which maiass)
   chmod +x $(which maiass)
   ```
2. **Check directory permissions**:
   ```bash
   ls -la .
   # Ensure you have write access to current directory
   ```

### Version Management Issues

#### Version files not being updated
**Symptoms**: MAIASS runs but version numbers don't change in files.

**Diagnosis**:
```bash
# Enable debug mode
export MAIASS_DEBUG="true"
export MAIASS_VERBOSITY="debug"
maiass patch
```

**Solutions**:
1. **Check file permissions**:
   ```bash
   ls -la package.json VERSION style.css
   # Ensure files are writable
   ```

2. **Verify configuration**:
   ```bash
   # Check primary file settings
   echo $MAIASS_VERSION_PRIMARY_FILE
   echo $MAIASS_VERSION_PRIMARY_TYPE
   echo $MAIASS_VERSION_PRIMARY_LINE_START
   ```

3. **Test pattern matching**:
   ```bash
   # For txt files, verify line prefix
   grep "^Version: " style.css
   
   # For pattern files, check syntax
   grep "define('VERSION'" functions.php
   ```

#### "Invalid version format" errors
**Symptoms**: MAIASS rejects version numbers or can't parse existing versions.

**Solutions**:
1. **Check current version format**:
   ```bash
   # Should be X.Y.Z format
   cat VERSION
   grep '"version"' package.json
   ```

2. **Fix malformed versions**:
   ```bash
   # Remove extra characters
   echo "1.2.3" > VERSION
   
   # Fix JSON syntax
   # Ensure: "version": "1.2.3"
   ```

3. **Validate semantic versioning**:
   - Must be three numbers: `1.2.3`
   - No prefixes like `v1.2.3` in version files
   - No extra text or spaces

### Git Workflow Issues

#### Misleading success messages for missing branches
**Symptoms**: MAIASS shows "✔ Merged main into develop" even when develop branch doesn't exist.

**Explanation**: This is a known issue where MAIASS displays success messages for branch operations that were skipped due to missing branches.

**Workaround**:
1. **Check actual branch status**:
   ```bash
   git branch -a
   git log --oneline -5
   ```

2. **Create missing branches if needed**:
   ```bash
   git checkout -b develop
   git push -u origin develop
   ```

3. **Use debug mode to see actual operations**:
   ```bash
   export MAIASS_VERBOSITY="debug"
   maiass patch
   ```

#### "Branch 'develop' does not exist" warnings
**Symptoms**: Warning messages about missing branches but workflow continues.

**Solutions**:
1. **Configure for your branch structure**:
   ```bash
   # .env file
   MAIASS_DEVELOPBRANCH=main
   MAIASS_MASTERBRANCH=main
   MAIASS_STAGINGBRANCH=staging
   ```

2. **Create missing branches**:
   ```bash
   git checkout -b develop
   git checkout -b staging
   ```

3. **Use single-branch workflow**:
   ```bash
   # Work only on current branch
   MAIASS_DEVELOPBRANCH=$(git branch --show-current)
   MAIASS_MASTERBRANCH=$(git branch --show-current)
   ```

#### Git tag conflicts
**Symptoms**: "Tag already exists" errors when creating version tags.

**Solutions**:
1. **List existing tags**:
   ```bash
   git tag -l
   git tag -l "v*"
   ```

2. **Delete conflicting tag**:
   ```bash
   git tag -d v1.2.3
   git push origin :refs/tags/v1.2.3  # if pushed
   ```

3. **Use different version number**:
   ```bash
   maiass 1.2.4  # Skip to next version
   ```

### AI Integration Issues

#### "OpenAI API key not found"
**Symptoms**: AI features don't work, API key errors.

**Solutions**:
1. **Verify API key is set**:
   ```bash
   echo $MAIASS_AI_TOKEN
   # Should show: sk-...
   ```

2. **Check .env file**:
   ```bash
   cat .env | grep OPENAI
   # Should show: MAIASS_AI_TOKEN=sk-...
   ```

3. **Source .env file**:
   ```bash
   source .env
   export MAIASS_AI_TOKEN="your_key_here"
   ```

#### "API request failed" errors
**Symptoms**: AI requests timeout or fail.

**Solutions**:
1. **Check internet connectivity**:
   ```bash
   curl -I https://api.openai.com
   ```

2. **Verify API key validity**:
   ```bash
   curl -H "Authorization: Bearer $MAIASS_AI_TOKEN" \
        https://api.openai.com/v1/models
   ```

3. **Try different model**:
   ```bash
   export MAIASS_AI_MODEL="gpt-3.5-turbo"
   ```

4. **Check OpenAI account credits**:
   - Visit [OpenAI Platform](https://platform.openai.com/)
   - Check usage and billing

#### "No changes to analyze" for AI
**Symptoms**: AI can't generate commit messages.

**Solutions**:
1. **Ensure changes are staged**:
   ```bash
   git add .
   git status
   ```

2. **Check git diff**:
   ```bash
   git diff --cached
   # Should show staged changes
   ```

### Repository Detection Issues

#### "Repository not detected" for pull requests
**Symptoms**: MAIASS can't generate GitHub/Bitbucket PR URLs.

**Solutions**:
1. **Check git remotes**:
   ```bash
   git remote -v
   # Should show GitHub or Bitbucket URLs
   ```

2. **Manual configuration**:
   ```bash
   # .env file
   MAIASS_GITHUB_OWNER=yourusername
   MAIASS_GITHUB_REPO=your-repo
   ```

3. **Fix remote URLs**:
   ```bash
   git remote set-url origin https://github.com/user/repo.git
   ```

### Performance Issues

#### Slow execution
**Symptoms**: MAIASS takes a long time to complete.

**Solutions**:
1. **Reduce verbosity**:
   ```bash
   export MAIASS_VERBOSITY="brief"
   ```

2. **Disable AI for speed**:
   ```bash
   export MAIASS_AI_MODE="off"
   ```

3. **Check network connectivity**:
   ```bash
   # Test git remote access
   git ls-remote origin
   ```

## Debug Mode

### Enabling Debug Output

```bash
# Enable comprehensive debugging
export MAIASS_DEBUG="true"
export MAIASS_VERBOSITY="debug"
maiass patch
```

### Debug Information Includes

- **Configuration loading**: Shows which .env files are loaded
- **Branch detection**: Displays available branches and remotes
- **Version file processing**: Shows file reading/writing operations
- **Git operations**: Reveals actual git commands executed
- **AI interactions**: Shows API requests and responses
- **Pattern matching**: Displays regex operations for version files

### Logging to File

```bash
# Enable logging for persistent debugging
export MAIASS_LOGGING="true"
export MAIASS_LOG_FILE="debug.log"
maiass patch

# Review log file
cat debug.log
```

## Getting Help

### Before Reporting Issues

1. **Run with debug mode**:
   ```bash
   MAIASS_DEBUG=true MAIASS_VERBOSITY=debug maiass patch 2>&1 | tee debug.log
   ```

2. **Gather system information**:
   ```bash
   # System info
   uname -a
   bash --version
   git --version
   jq --version
   
   # MAIASS info
   maiass --help | head -5
   which maiass
   ```

3. **Check configuration**:
   ```bash
   env | grep MAIASS
   cat .env 2>/dev/null || echo "No .env file"
   ```

### Reporting Bugs

When reporting issues, include:

1. **Error message** (exact text)
2. **Debug output** (from debug mode)
3. **System information** (OS, bash version, etc.)
4. **Repository structure** (branch names, remotes)
5. **Configuration** (.env contents, minus API keys)
6. **Steps to reproduce**

### Community Support

- **GitHub Issues**: [github.com/vsmash/maiass/issues](https://github.com/vsmash/maiass/issues)
- **Discussions**: [github.com/vsmash/maiass/discussions](https://github.com/vsmash/maiass/discussions)
- **Documentation**: [docs/](./)

## Quick Fixes

### Reset MAIASS Configuration

```bash
# Remove local configuration
rm .env

# Reset to defaults
unset $(env | grep MAIASS | cut -d= -f1)

# Test basic functionality
maiass --help
```

### Verify Installation

```bash
#!/bin/bash
# Quick verification script

echo "Checking MAIASS installation..."

# Check command availability
if command -v maiass >/dev/null 2>&1; then
    echo "✓ MAIASS command found"
else
    echo "✗ MAIASS command not found"
    exit 1
fi

# Check dependencies
if command -v jq >/dev/null 2>&1; then
    echo "✓ jq found"
else
    echo "✗ jq not found - install with: brew install jq"
fi

# Check git
if command -v git >/dev/null 2>&1; then
    echo "✓ git found"
else
    echo "✗ git not found"
fi

# Test basic functionality
if maiass --help >/dev/null 2>&1; then
    echo "✓ MAIASS help works"
else
    echo "✗ MAIASS help failed"
fi

echo "Verification complete!"
```