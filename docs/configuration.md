# Configuration Guide

## Zero Configuration by Default

**MAIASS works out of the box with sensible defaults.** You don't need to create any configuration files unless you want to:

- **Override default branch names** (if your project uses different branch names)
- **Enable AI features** (set AI API token globally in `~/.maiass.env`)
- **Customize version file handling** (for non-standard project structures)
- **Modify workflow behavior** (disable pull requests, change verbosity, etc.)

## When to Use Configuration

### ✅ You DON'T need configuration if:
- Your project uses standard branch names (`develop`, `staging`, `master`)
- You have a `package.json` or `VERSION` file for versioning
- You're happy with the default workflow behavior
- You don't want AI-powered commit messages

### ⚙️ You DO need configuration if:
- Your project uses different branch names (e.g., `main` instead of `master`) → **Project-level** `.env.maiass`
- You want AI-powered commit messages (set AI API token) → **Global** `~/.maiass.env` or **Personal** `.env.maiass.local`
- You have custom version files or multiple version files to update → **Project-level** `.env.maiass`
- You want to disable pull request creation or modify other behaviors → **Project-level** `.env.maiass`

## Environment Configuration

MAIASS uses environment variables for configuration. You can set these in several ways:

### Configuration Priority

1. **Global config**: `~/.maiass.env` (loaded first)
2. **Project config**: `.env.maiass` in project root (overrides global, committed to repo)
3. **Personal config**: `.env.maiass.local` in project root (overrides project config, ignored by git)
4. **Environment variables**: Direct exports (highest priority)

## Configuration Examples

**Remember: You only need to set variables when overriding defaults!**

### Example 1: Global AI Setup (Recommended)
```bash
# ~/.maiass.env - set once for all projects
MAIASS_AI_TOKEN=your_openai_api_key_here
MAIASS_AI_MODE=ask
```

### Example 2: Project-Level Branch Override
```bash
# .env.maiass file in project root - for projects using 'main' instead of 'master'
MAIASS_MASTERBRANCH=main
```

### Example 3: Personal Development Overrides
```bash
# .env.maiass.local file in project root - personal settings (ignored by git)
MAIASS_AI_TOKEN=your_personal_api_key_here
MAIASS_VERBOSITY=debug
MAIASS_AI_MODE=autosuggest
```

### Example 4: Comprehensive Configuration
```bash
# .env.maiass file - full configuration example (most users won't need all of these)

# AI Configuration
MAIASS_AI_MODE=ask                    # Default: off
MAIASS_AI_MODEL=gpt-4o               # Default: gpt-4o
MAIASS_AI_COMMIT_MESSAGE_STYLE=bullet # Default: bullet

# Branch Configuration (only set if different from defaults)
MAIASS_DEVELOPBRANCH=develop             # Default: develop
MAIASS_STAGINGBRANCH=staging             # Default: staging  
MAIASS_MASTERBRANCH=main                 # Default: master (change to 'main' if needed)

# Output & Logging Configuration (only set if changing defaults)
MAIASS_VERBOSITY=normal                  # Default: brief (options: brief, normal, debug)
MAIASS_LOGGING=true                      # Default: false (set to true to enable)
MAIASS_LOG_FILE=custom.log               # Default: maiass.log

# Repository Configuration (usually auto-detected, manual override if needed)
MAIASS_GITHUB_OWNER=yourusername
MAIASS_GITHUB_REPO=your-repo
MAIASS_BITBUCKET_WORKSPACE=yourworkspace
MAIASS_BITBUCKET_REPO_SLUG=your-repo-slug

# Browser Configuration (only set if changing defaults)
MAIASS_BROWSER="Firefox"                 # Default: system default
MAIASS_BROWSER_PROFILE="Work"            # Default: Default
```

## Environment Variables Reference

### Core Configuration Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `MAIASS_DEVELOPBRANCH` | `develop` | Development branch name |
| `MAIASS_STAGINGBRANCH` | `staging` | Staging branch name |
| `MAIASS_MASTERBRANCH` | `master` | Production branch name |
| `MAIASS_VERBOSITY` | `brief` | Output verbosity: `brief`, `normal`, `debug` |
| `MAIASS_LOGGING` | `false` | Enable logging to file |
| `MAIASS_LOG_FILE` | `maiass.log` | Log file path |

> `MAIASS_DEVELOPBRANCH` is also substituted into the CI workflow templates produced by `maiass --create-gh-action`, `--show-gl-excerpt`, and `--show-bb-excerpt` at the moment those commands run. The trigger fires on your actual develop branch, not the literal string `develop`. Defaults to `develop` when unset.

> The generated workflow includes a `MAIASS_CI_FAIL_SILENTLY` env var (default `false`) that controls what happens when the push credential is missing: `false` fails the run with a clear message so it's noticed (the merge itself is unaffected — the workflow runs *after* merge); `true` skips with a warning and keeps the run green. It lives in the generated YAML — **not** in `.env.maiass` — so edit it there.

> **Deprecated (MAI-63):** `MAIASS_STAGING_PULLREQUESTS` and
> `MAIASS_MASTER_PULLREQUESTS` / `MAIASS_MAIN_PULLREQUESTS` are no longer read.
> They only fed the removed post-bump deploy menu; setting them now has no
> effect. `MAIASS_STAGINGBRANCH` / `MAIASS_MASTERBRANCH` remain in use for
> branch detection.

### AI Configuration Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `MAIASS_AI_TOKEN` | *(none)* | AI API token (required for AI features) |
| `MAIASS_AI_MODE` | `off` | AI mode: `off`, `ask`, `autosuggest` |
| `MAIASS_AI_MODEL` | `gpt-4o` | AI model: `gpt-4o`, `gpt-4`, `gpt-3.5-turbo` |
| `MAIASS_AI_COMMIT_MESSAGE_STYLE` | `bullet` | Commit message style: `bullet`, `conventional`, `simple` |

### Repository Integration Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `MAIASS_GITHUB_OWNER` | *(auto-detected)* | GitHub repository owner/username |
| `MAIASS_GITHUB_REPO` | *(auto-detected)* | GitHub repository name |
| `MAIASS_BITBUCKET_WORKSPACE` | *(auto-detected)* | Bitbucket workspace name |
| `MAIASS_BITBUCKET_REPO_SLUG` | *(auto-detected)* | Bitbucket repository slug |

### Browser Configuration Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `MAIASS_BROWSER` | *(system default)* | Browser for opening URLs |
| `MAIASS_BROWSER_PROFILE` | `Default` | Browser profile to use |

### Version File Configuration Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `MAIASS_VERSION_PRIMARY_FILE` | *(auto-detected)* | Primary version file (package.json, VERSION, etc.) |
| `MAIASS_VERSION_PRIMARY_TYPE` | *(auto-detected)* | File type: `json`, `txt`, `pattern` |
| `MAIASS_VERSION_PRIMARY_LINE_START` | *(varies by type)* | Line prefix for txt files |
| `MAIASS_VERSION_SECONDARY_FILES` | *(none)* | Additional files to update (pipe-separated) |

### Changelog Configuration Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `MAIASS_CHANGELOG_FILE` | `CHANGELOG.md` | Changelog file path |
| `MAIASS_CHANGELOG_SECTIONS` | *(standard)* | Changelog sections configuration |
| `MAIASS_CHANGELOG_DATE_FORMAT` | `%Y-%m-%d` | Date format for changelog entries |
| `MAIASS_CHANGELOG_TEMPLATE` | *(built-in)* | Custom changelog template |

#### Internal Changelog (tracked on develop)

The internal changelog is a tracked source of truth on `develop` and should not be added to `.gitignore`. Control exposure via deployment tooling (e.g., CI rules).

- `MAIASS_CHANGELOG_INTERNAL_NAME` — Internal changelog filename (default: `.CHANGELOG_internal.md`)
- `MAIASS_CHANGELOG_INTERNAL_PATH` — Internal changelog directory (defaults to `MAIASS_CHANGELOG_PATH` if unset)

## Output Control & Logging

MAIASS provides configurable output verbosity and optional logging to help you control the amount of information displayed and maintain audit trails.

### Verbosity Levels

- **`brief`** (default): Shows only essential messages - version changes, errors, and critical workflow steps
- **`normal`**: Includes configuration details, branch information, and progress updates
- **`debug`**: Shows all messages including detailed operations, git commands, and internal processing

```bash
# Set verbosity level
export MAIASS_VERBOSITY="normal"
maiass patch

# Enable debug mode for troubleshooting
export MAIASS_VERBOSITY="debug"
maiass minor
```

### Logging

When logging is enabled, all output is captured to a file with timestamps for audit and debugging purposes:

```bash
# Enable logging
export MAIASS_LOGGING="true"
export MAIASS_LOG_FILE="maiass.log"
maiass patch
```

**Automatic .gitignore Management:**
- Script automatically checks if log files are in `.gitignore`
- Prompts to add log file patterns if missing
- Prevents accidental commits of log files

## Repository Auto-Detection

MAIASS automatically detects repository information:

- **GitHub repositories**: Extracts owner/repo from remote URLs
- **Bitbucket repositories**: Extracts workspace/repo-slug from remote URLs
- **Branch structure**: Adapts to existing branch naming conventions
- **Version files**: Detects `package.json`, `VERSION` files, or custom configurations

## Custom Configuration Examples

### WordPress Theme Development
```bash
# .env for WordPress theme
MAIASS_VERSION_PRIMARY_FILE="style.css"
MAIASS_VERSION_PRIMARY_TYPE="txt"
MAIASS_VERSION_PRIMARY_LINE_START="Version: "
MAIASS_VERSION_SECONDARY_FILES="functions.php:pattern:define('MYTHEME_VERSION','{version}');"
MAIASS_MASTERBRANCH="main"
MAIASS_DEVELOPBRANCH="develop"
```

### Node.js Project
```bash
# .env for Node.js project
MAIASS_VERSION_PRIMARY_FILE="package.json"
MAIASS_VERSION_PRIMARY_TYPE="json"
MAIASS_AI_MODE="ask"
MAIASS_AI_COMMIT_MESSAGE_STYLE="conventional"
```

### Shell Script Project
```bash
# .env for shell script project
MAIASS_VERSION_PRIMARY_FILE="myscript.sh"
MAIASS_VERSION_PRIMARY_TYPE="txt"
MAIASS_VERSION_PRIMARY_LINE_START="# Version: "
MAIASS_VERBOSITY="normal"
MAIASS_LOGGING="true"
```
