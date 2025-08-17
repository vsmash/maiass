# Pull Request Integration

## Overview

MAIASS automatically generates pull request URLs for GitHub and Bitbucket repositories, streamlining your workflow by opening PR creation pages with pre-filled source and target branches.

## Supported Platforms

### GitHub
- Automatically detects GitHub repositories from remote URLs
- Creates PR URLs with quick pull request format
- Supports both public and private repositories
- Works with GitHub Enterprise instances

### Bitbucket
- Automatically detects Bitbucket repositories from remote URLs
- Creates PR URLs with source and destination branches
- Supports both Bitbucket Cloud and Server
- Works with private workspaces

## Configuration

### Automatic Detection

MAIASS automatically detects repository information from git remotes:

```bash
# GitHub repository
git remote -v
# origin  https://github.com/username/repo.git (fetch)
# origin  https://github.com/username/repo.git (push)

# Bitbucket repository
git remote -v
# origin  https://bitbucket.org/workspace/repo.git (fetch)
# origin  https://bitbucket.org/workspace/repo.git (push)
```

### Manual Configuration

You can override auto-detection by setting environment variables:

```bash
# GitHub configuration
MAIASS_GITHUB_OWNER=yourusername
MAIASS_GITHUB_REPO=your-repo

# Bitbucket configuration
MAIASS_BITBUCKET_WORKSPACE=yourworkspace
MAIASS_BITBUCKET_REPO_SLUG=your-repo-slug
```

### Pull Request Control

Control when pull requests are offered:

```bash
# Enable/disable PR prompts for staging merges
MAIASS_STAGING_PULLREQUESTS=on    # on, off

# Enable/disable PR prompts for master merges
MAIASS_MASTER_PULLREQUESTS=on     # on, off
```

## How It Works

### GitHub Pull Requests

MAIASS generates GitHub PR URLs in this format:
```
https://github.com/owner/repo/compare/target...source?quick_pull=1
```

**Example:**
```bash
# Current branch: feature/user-auth
# Target branch: main
# Generated URL:
https://github.com/myuser/myrepo/compare/main...feature/user-auth?quick_pull=1
```

### Bitbucket Pull Requests

MAIASS generates Bitbucket PR URLs in this format:
```
https://bitbucket.org/workspace/repo/pull-requests/new?source=source&dest=target
```

**Example:**
```bash
# Current branch: feature/user-auth
# Target branch: develop
# Generated URL:
https://bitbucket.org/myworkspace/myrepo/pull-requests/new?source=feature/user-auth&dest=develop
```

## Workflow Integration

### Git Flow Workflow

In a full Git Flow setup, MAIASS offers pull requests at key merge points:

1. **Feature → Develop**: When merging feature branches
2. **Develop → Staging**: When deploying to staging
3. **Staging → Master**: When deploying to production

```bash
# Example workflow
maiass minor

# Output:
# ✓ Merged feature/user-auth into develop
# 
# Deploy to staging?
# 1) Create Pull Request
# 2) Direct merge
# 3) Skip
```

### Simple Workflow

In simpler workflows, MAIASS offers pull requests for:

1. **Feature → Main**: When merging feature branches
2. **Any → Main**: When deploying changes

## Browser Integration

### Automatic Opening

MAIASS can automatically open pull request URLs in your browser:

```bash
# Configure browser (optional)
MAIASS_BROWSER="Google Chrome"
MAIASS_BROWSER_PROFILE="Profile 1"
```
`MAIASS_BROWSER_PROFILE` is for multiple profiles on chrome or brave browsers and is optional

### Supported Browsers

- **macOS**: Safari, Chrome, Firefox, Edge, Brave
- **Linux**: Default browser, Chrome, Firefox
- **Windows (WSL)**: Uses Windows default browser

## Jira Integration

When creating pull requests, MAIASS automatically includes Jira ticket information:

```bash
# Branch: feature/PROJ-123-user-authentication
# PR title will include: [PROJ-123]
# PR description may include ticket details
```

## Advanced Features

### Custom PR Templates

MAIASS does not yet recognize custom PR templates.

### Draft Pull Requests

For GitHub repositories, you can create draft PRs by modifying the URL:

```bash
# Standard PR
https://github.com/owner/repo/compare/main...feature?quick_pull=1

# Draft PR (add &draft=1)
https://github.com/owner/repo/compare/main...feature?quick_pull=1&draft=1
```

## Troubleshooting

### Common Issues

**"Repository not detected"**
- Verify git remote is configured: `git remote -v`
- Check remote URL format matches GitHub/Bitbucket patterns
- Manually set `MAIASS_GITHUB_OWNER` and `MAIASS_GITHUB_REPO`

**"PR URL not opening"**
- Check browser configuration
- Verify internet connectivity
- Try copying URL manually

**"Wrong repository detected"**
- Check multiple remotes: `git remote -v`
- Set explicit configuration in `.env`
- Verify remote URL is correct

### Debug Mode

```bash
export MAIASS_DEBUG="true"
export MAIASS_VERBOSITY="debug"
maiass patch

# Shows repository detection process
# Displays generated PR URLs
# Reveals browser opening attempts
```

## Best Practices

1. **Use descriptive branch names** - They become PR titles
2. **Include ticket numbers** - MAIASS will extract them automatically
3. **Configure PR templates** - Standardize PR descriptions
4. **Review before creating** - URLs are generated but not automatically submitted
5. **Test with small changes** - Verify PR integration works as expected

## Examples

### GitHub Example

```bash
# Repository: https://github.com/mycompany/webapp
# Current branch: feature/WEBAPP-456-login-fix
# Target: main

maiass patch

# Output:
# ✓ Version bumped to 1.2.4
# ✓ Created tag v1.2.4
# 
# Merge to main?
# 1) Create Pull Request: https://github.com/mycompany/webapp/compare/main...feature/WEBAPP-456-login-fix?quick_pull=1
# 2) Direct merge
# 3) Skip
```

### Bitbucket Example

```bash
# Repository: https://bitbucket.org/myteam/api
# Current branch: bugfix/API-789-validation
# Target: develop

maiass minor

# Output:
# ✓ Version bumped to 1.3.0
# ✓ Merged into develop
# 
# Deploy to staging?
# 1) Create Pull Request: https://bitbucket.org/myteam/api/pull-requests/new?source=develop&dest=staging
# 2) Direct merge
# 3) Skip
```
