# Advanced Usage

## Complex Workflows

### Multi-Environment Deployments

MAIASS supports sophisticated deployment workflows with multiple environments:

```bash
# .env configuration for multi-stage deployment
MAIASS_DEVELOPBRANCH="develop"
MAIASS_STAGINGBRANCH="staging"
MAIASS_MASTERBRANCH="main"

# Enable pull requests for each stage
MAIASS_STAGING_PULLREQUESTS="true"
MAIASS_MASTER_PULLREQUESTS="true"

# Configure browser integration
MAIASS_BROWSER="chrome"
MAIASS_BROWSER_PROFILE="work"
```

**Workflow Example**:
```bash
# Feature development
git checkout -b feature/new-feature
# ... make changes ...
maiass patch  # Bumps version, commits, merges to develop

# Staging deployment
git checkout staging
maiass minor  # Promotes to staging with minor version bump

# Production deployment
git checkout main
maiass major  # Promotes to production with major version bump
```

### Custom Version File Systems

MAIASS can handle complex version file configurations:

#### WordPress Theme/Plugin
```bash
# Primary version in style.css header
MAIASS_VERSION_PRIMARY_FILE="style.css"
MAIASS_VERSION_PRIMARY_TYPE="txt"
MAIASS_VERSION_PRIMARY_LINE_START="Version: "

# Secondary versions in PHP files
MAIASS_VERSION_SECONDARY_FILES="functions.php:pattern:define('VERSION', '|readme.txt:txt:Stable tag: "
```

#### Multi-Package Monorepo
```bash
# Primary package.json
MAIASS_VERSION_PRIMARY_FILE="packages/core/package.json"
MAIASS_VERSION_PRIMARY_TYPE="json"

# Update all package.json files
MAIASS_VERSION_SECONDARY_FILES="packages/ui/package.json:json:|packages/utils/package.json:json:|package.json:json:"
```

#### Custom Application
```bash
# Version in config file
MAIASS_VERSION_PRIMARY_FILE="config/app.yml"
MAIASS_VERSION_PRIMARY_TYPE="txt"
MAIASS_VERSION_PRIMARY_LINE_START="version: "

# Also update documentation
MAIASS_VERSION_SECONDARY_FILES="README.md:txt:Version |docs/installation.md:txt:Current version: "
```

## Advanced AI Configuration

### Custom AI Prompts and Styles

```bash
# Use different models for different scenarios
MAIASS_AI_MODEL="gpt-4o"  # For complex changes
# MAIASS_AI_MODEL="gpt-3.5-turbo"  # For simple changes

# Customize commit message style
MAIASS_AI_COMMIT_MESSAGE_STYLE="conventional"
```

### AI Integration with Jira

MAIASS automatically detects Jira ticket numbers from branch names:

```bash
# Branch naming patterns that work:
git checkout -b feature/PROJ-123-user-authentication
git checkout -b bugfix/ISSUE-456-fix-login-error
git checkout -b hotfix/TICKET-789-security-patch

# AI will include ticket references in commit messages:
# "[PROJ-123] Add user authentication system"
# "[ISSUE-456] Fix login validation error"
```

## Repository Integration

If you have bitbucket or github as part of  your .ssh config, MAIASS will automatically detect the repository provider and use it.

```bash
# Repository detection override
MAIASS_REPO_PROVIDER="github"
```

### GitHub Advanced Configuration

```bash
# Manual repository configuration
MAIASS_GITHUB_OWNER="your-organization"
MAIASS_GITHUB_REPO="your-repository"

# Custom pull request templates
# MAIASS will open URLs like:
# https://github.com/your-org/your-repo/compare/main...staging?expand=1
```

### Bitbucket Advanced Configuration

```bash
# Bitbucket workspace and repository
MAIASS_BITBUCKET_WORKSPACE="your-workspace"
MAIASS_BITBUCKET_REPO_SLUG="your-repo-slug"

# MAIASS generates URLs like:
# https://bitbucket.org/workspace/repo/pull-requests/new?source=staging&dest=main
```

### Enterprise Git Servers

For custom Git servers, MAIASS provides core functionality:

```bash
# Works with any Git remote
git remote add origin https://git.company.com/project/repo.git

# Core features work:
# - Version management
# - Branch operations
# - Tag creation
# - AI commit messages

# Pull request URLs won't be generated (GitHub/Bitbucket only)
```

## Logging and Monitoring

### Comprehensive Logging

```bash
# Enable detailed logging
export MAIASS_LOGGING="true"
export MAIASS_LOG_FILE="maiass-$(date +%Y%m%d).log"
export MAIASS_VERBOSITY="debug"

# Run with full logging
maiass patch

# Analyze logs
grep "ERROR" maiass-*.log
grep "AI:" maiass-*.log  # AI interactions
grep "GIT:" maiass-*.log  # Git operations
```

### Log Rotation

```bash
#!/bin/bash
# Log rotation script

LOG_DIR="$HOME/.maiass/logs"
mkdir -p "$LOG_DIR"

# Set rotating log file
export MAIASS_LOG_FILE="$LOG_DIR/maiass-$(date +%Y%m%d).log"

# Clean old logs (keep 30 days)
find "$LOG_DIR" -name "maiass-*.log" -mtime +30 -delete
```

## CI/CD Integration

### GitHub Actions

```yaml
# .github/workflows/release.yml
name: Release
on:
  push:
    branches: [main]

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Install dependencies
        run: |
          sudo apt-get update
          sudo apt-get install -y jq
      - name: Install MAIASS
        run: |
          curl -sSL https://raw.githubusercontent.com/vsmash/maiass/main/install.sh | bash
      - name: Configure MAIASS
        env:
          MAIASS_AI_TOKEN: ${{ secrets.OPENAI_API_KEY }}
        run: |
          export MAIASS_AI_MODE="autosuggest"
          export MAIASS_VERBOSITY="brief"
          maiass patch
```

### GitLab CI

```yaml
# .gitlab-ci.yml
stages:
  - release

release:
  stage: release
  image: ubuntu:latest
  before_script:
    - apt-get update && apt-get install -y git jq curl bash
    - curl -sSL https://raw.githubusercontent.com/vsmash/maiass/main/install.sh | bash
  script:
    - export MAIASS_AI_MODE="off"  # No AI in CI
    - export MAIASS_VERBOSITY="brief"
    - maiass patch
  only:
    - main
```

## Performance Optimization

### Speed Optimization

```bash
# Minimal configuration for speed
export MAIASS_VERBOSITY="brief"      # Reduce output
export MAIASS_AI_MODE="off"      # Skip AI processing
export MAIASS_LOGGING="false"        # Disable logging

# Skip unnecessary operations
export MAIASS_STAGING_PULLREQUESTS="false"
export MAIASS_MASTER_PULLREQUESTS="false"
```

### Large Repository Handling

```bash
# For repositories with large histories
export GIT_DEPTH="--depth=1"  # Shallow clones in CI

# Optimize git operations
git config core.preloadindex true
git config core.fscache true
git config gc.auto 256
```

## Security Considerations

### API Key Management

```bash
# Use environment-specific configurations
# Development
cp .env.development .env

# Production (no API keys in repo)
export MAIASS_AI_TOKEN="$(cat ~/.secrets/openai-key)"

# CI/CD (use secret management)
# Set MAIASS_AI_TOKEN in CI environment variables
```

### Secure Logging

```bash
# Ensure logs don't contain sensitive data
export MAIASS_LOG_SANITIZE="true"  # Future feature

# Restrict log file permissions
chmod 600 maiass.log

# Use secure log directory
mkdir -p ~/.maiass/logs
chmod 700 ~/.maiass/logs
```

## Troubleshooting Complex Scenarios

### Debug Mode for Complex Issues

```bash
# Maximum debugging information
export MAIASS_DEBUG="true"
export MAIASS_VERBOSITY="debug"
export MAIASS_LOGGING="true"
export MAIASS_LOG_FILE="debug-$(date +%s).log"

# Run problematic command
maiass patch 2>&1 | tee console-output.log

# Analyze both console and log file
grep -E "(ERROR|WARN|FAIL)" debug-*.log console-output.log
```

### Network Issues

```bash
# Test connectivity
curl -I https://api.openai.com
git ls-remote origin

# Use proxy if needed
export https_proxy="http://proxy.company.com:8080"
export http_proxy="http://proxy.company.com:8080"
```

### Version Conflicts

```bash
# Check for version inconsistencies
grep -r "version" package.json VERSION *.md

# Force version synchronization
MAIASS_FORCE_VERSION_SYNC="true" maiass 1.2.3
```

## Custom Extensions

### Pre/Post Hooks

While MAIASS doesn't have built-in hooks, you can create wrapper scripts:

```bash
#!/bin/bash
# maiass-wrapper.sh

# Pre-hook
echo "Running pre-deployment checks..."
npm test || exit 1

# Run MAIASS
maiass "$@"
MAIASS_EXIT_CODE=$?

# Post-hook
if [ $MAIASS_EXIT_CODE -eq 0 ]; then
    echo "Deployment successful, sending notification..."
    curl -X POST "$SLACK_WEBHOOK" -d '{"text":"Deployment completed"}'
fi

exit $MAIASS_EXIT_CODE
```

### Custom Version Parsers

For extremely custom version formats:

```bash
#!/bin/bash
# custom-version-handler.sh

# Extract current version
current_version=$(grep "APP_VERSION" config.ini | cut -d'=' -f2)

# Let MAIASS handle the logic
echo "$current_version" > .maiass-temp-version
MAIASS_VERSION_PRIMARY_FILE=".maiass-temp-version" maiass "$@"
new_version=$(cat .maiass-temp-version)

# Apply to custom format
sed -i "s/APP_VERSION=.*/APP_VERSION=$new_version/" config.ini
rm .maiass-temp-version
```

## Best Practices for Advanced Users

### Configuration Management

1. **Environment-specific configs**: Use `.env.development`, `.env.staging`, `.env.production`
2. **Team sharing**: Provide `.env.example` with safe defaults
3. **Documentation**: Document custom configurations in project README
4. **Validation**: Test configurations in non-production environments first

### Workflow Design

1. **Consistent branching**: Establish clear branch naming conventions
2. **Version strategy**: Define semantic versioning rules for your project
3. **Testing integration**: Ensure MAIASS fits your testing workflow
4. **Rollback plans**: Have procedures for reverting problematic releases

### Monitoring and Maintenance

1. **Log analysis**: Regularly review MAIASS logs for issues
2. **Performance tracking**: Monitor execution times and optimize
3. **Update management**: Keep MAIASS updated for new features and fixes
4. **Team training**: Ensure team members understand the workflow

## Integration Examples

### Slack Notifications

```bash
# Add to your workflow
SLACK_WEBHOOK="https://hooks.slack.com/services/..."

# After successful MAIASS run
curl -X POST "$SLACK_WEBHOOK" \
  -H 'Content-type: application/json' \
  --data "{\"text\":\"🚀 Version $(cat VERSION) deployed to staging\"}"
```

### Email Notifications

```bash
# Using mail command
echo "Version $(cat VERSION) has been deployed" | \
  mail -s "Deployment Notification" team@company.com
```

### Database Updates

```bash
# Update application database with new version
mysql -u user -p database <<EOF
UPDATE app_config SET version = '$(cat VERSION)' WHERE key = 'app_version';
EOF
```

This advanced usage guide covers sophisticated scenarios and configurations that power users might encounter when integrating MAIASS into complex development workflows.