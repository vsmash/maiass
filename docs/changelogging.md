# Changelog Management

MAIASS provides changelog management functionality to track version history in your project, with AI-enhanced features for intelligent categorization.

## Basic Changelog Generation

### Default Behavior

MAIASS automatically creates and updates changelog files:

- **CHANGELOG.md**: Primary changelog file (created automatically)
- **CHANGELOG\_internal.md**: Internal changelog with detailed commit information (updated only if it already exists)

These files are updated on the `develop` branch, which MAIASS treats as the source of truth. To avoid merge conflicts or incorrect history, changelog edits should be made only on or from `develop`.

Each version bump includes:

- Version number and date
- Git commit messages since last tag
- Basic formatting

The internal changelog additionally:

- Prepends the Jira ticket number when the commit branch includes one after the last slash (e.g. `somebranch/JIR-123_fixsomething` results in `[JIR-123]`)
- Appends the commit with the author name

### Changelog Format

```markdown
# Changelog

## 4.6.4
13 July 2025

- Fix typo in variable name within commit logging
- fix: corrected variable name from `mylog_message` to `devlog_message`
- Refactored logging and removed unused function
- refactor: redirected logging output to stderr
- feat: added placeholder message for `run_ai_commit_only` function
- Update README with clarification on target audience
- docs: revised README to specify target audience as developers needing help with commit messages and versioning
```

## Configuration

### Changelog File Location

MAIASS uses these default changelog files:

- `CHANGELOG.md` - Main changelog (created automatically)
- `.CHANGELOG_internal.md` - Internal changelog with commit details (updated only if it already exists)

### Custom Changelog Configuration

You can customize changelog settings using environment variables:

```bash
# Custom changelog path
export MAIASS_CHANGELOG_PATH="./docs"

# Custom changelog filename
export MAIASS_CHANGELOG_NAME="HISTORY.md"

# Custom internal changelog filename
export MAIASS_CHANGELOG_INTERNAL_NAME="RELEASES.md"
```

## AI-Enhanced Changelog Generation

### Intelligent Categorization

When AI integration is enabled, MAIASS can generate conventional commit messages that provide structure for changelog entries:

```bash
# Enable AI for commit message generation
export MAIASS_AI_MODE="ask"
export MAIASS_AI_TOKEN="your_api_key"
export MAIASS_AI_COMMIT_MESSAGE_STYLE="conventional"
```

**AI generates conventional commit messages with prefixes**:

- **feat**: New features and functionality
- **fix**: Bug fixes and corrections
- **docs**: Documentation changes
- **refactor**: Code refactoring
- **chore**: Maintenance tasks
- **style**: Code style changes

### Example AI-Generated Commits

```bash
# AI will generate commits like:
feat: add user authentication system
fix: resolve login validation error
docs: update installation instructions
refactor: optimize database queries
```

These prefixes allow for manual or script-Augmented categorization.

## Manual Changelog Categorization

### Using Conventional Commits for Organization

While MAIASS doesn't yet automatically categorize changelog entries, you can manually group them by prefix:

```markdown
## 4.6.4
13 July 2025

### Added
- feat: add user authentication system
- feat: implement OAuth2 support

### Changed
- refactor: optimize database queries
- style: update code formatting

### Fixed
- fix: resolve login validation error
- fix: correct variable name typo

### Documentation
- docs: update installation instructions
- docs: revise README for clarity
```

### Pre-commit Changelog Editing

If you'd like to edit the changelog manually, it is best to branch from develop or update it on the develop branch to minimise risk of merge conflicts. It is important to maintain the same format as the rest of the changelog.

## Jira Integration

### Automatic Ticket Detection

MAIASS detects Jira ticket numbers from branch names:

```bash
git checkout -b feature/PROJ-123-user-authentication
git checkout -b bugfix/ISSUE-456-fix-login-error
git checkout -b hotfix/TICKET-789-security-patch
```

It will include ticket references in commit messages:

```markdown
- [PROJ-123] Add user authentication system
- [ISSUE-456] Fix login validation error
```

These also appear in the `internal` changelog but not the changelog.

## How It Works

### Git Integration

MAIASS:

- Analyzes commits since last tag
- Filters out merge commits and bump-only commits
- Uses valid commit messages as bullet points
- Writes updates to the defined changelog files

### Version Management Workflow

On bump:

1. Identify commits since last version tag
2. Create a new entry with version and date
3. Write to `CHANGELOG.md`
4. Optionally write extended info to `CHANGELOG_internal.md`

## Best Practices

- Use the `develop` branch for changelog generation to avoid conflicts
- Stick to conventional commits where possible
- Let MAIASS manage version and changelog updates for consistency

## Troubleshooting

### Empty Changelog?

```bash
git log --oneline $(git describe --tags --abbrev=0)..HEAD
```

### File Not Found?

```bash
echo "$MAIASS_CHANGELOG_PATH/$MAIASS_CHANGELOG_NAME"
```

### AI Issues?

```bash
echo "$MAIASS_AI_MODE"
echo "${MAIASS_AI_TOKEN:0:10}..."
```

## Example Scripts

```bash
# categorize-changelog.sh
# Organize entries by prefix
grep "feat:" CHANGELOG.md > added.md
grep "fix:" CHANGELOG.md > fixed.md
grep "refactor:" CHANGELOG.md > changed.md
grep "docs:" CHANGELOG.md > documentation.md
```

MAIASS provides robust changelogging that grows with your project—manual when you need it, automated when you want it.

