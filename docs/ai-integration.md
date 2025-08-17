# AI Integration Guide

## Overview

MAIASS integrates with OpenAI to generate intelligent commit messages based on your code changes. This feature analyzes your git diff and creates contextually appropriate commit messages in various styles.

## Setup

### 1. Get an OpenAI API Key

1. Visit [OpenAI Platform](https://platform.openai.com/)
2. Create an account or sign in
3. Navigate to API Keys section
4. Create a new API key
5. Copy the key (starts with `sk-`)

### 2. Configure MAIASS

Add your API key to your `.env` file for your project or globally in `~/.maiass.env`:
Only `MAIASS_AI_TOKEN` is required. Other settings have defaults but can be overridden:
```bash
# AI Configuration
MAIASS_AI_TOKEN=your_api_key_here
MAIASS_AI_MODE=autosuggest
MAIASS_AI_MODEL=gpt-4o
MAIASS_AI_COMMIT_MESSAGE_STYLE=bullet
MAIASS_AI_MAX_CHARACTERS=8000
```

## AI Modes

### `off` (Default)
- No AI assistance
- Manual commit message entry only
- Fastest option

### `ask` (Default/Recommended)
- AI asks if you want to use AI to suggest commit messages
- You can approve, edit, or reject suggestions
- Interactive and safe
- Good balance of automation and control

### `autosuggest`
- AI retrieves commit message suggestions automatically
- You can approve, edit, or reject suggestions
- Quickest option if you are not wary about credits

## Commit Message Styles

### `bullet` (Default)
Creates bulleted list format:
```
• Add user authentication system
• Update login form validation
• Fix password reset functionality
```

### `conventional`
Follows [Conventional Commits](https://www.conventionalcommits.org/) format:
```
feat: add user authentication system

- implement JWT token handling
- add login/logout endpoints
- update user model with auth fields
```

### `simple`
Simple descriptive messages:
```
Add user authentication system with JWT support
```

## Supported Models

- **`gpt-4o`** (default) - Latest GPT-4 Omni model, best quality
- **`gpt-4`** - Standard GPT-4, high quality
- **`gpt-3.5-turbo`** - Faster and cheaper, good quality

```bash
# Use different model
MAIASS_AI_MODEL=gpt-3.5-turbo
```

## How AI Analysis Works

1. **Git Diff Analysis**: Examines staged changes using `git diff --cached`
2. **Context Understanding**: Analyzes file types, change patterns, and scope
3. **Jira Integration**: Automatically includes ticket numbers from branch names
4. **Style Application**: Formats message according to selected style
5. **Interactive Review**: Presents suggestion for approval (in `ask` mode)

## Advanced Features

### Jira Ticket Integration

AI automatically detects and includes Jira ticket numbers:

```bash
# Branch: feature/PROJ-123-user-auth
# AI will include: [PROJ-123] in commit message
```

### Context-Aware Suggestions

AI considers:
- **File types**: Different approaches for code vs. docs vs. config
- **Change scope**: Feature additions vs. bug fixes vs. refactoring
- **Project structure**: Adapts to your repository patterns
- **Commit history**: Learns from your existing commit style

### Multi-File Change Analysis

For complex changes across multiple files, AI provides:
- **Grouped changes**: Related modifications grouped logically
- **Priority ordering**: Most important changes listed first
- **Cross-file relationships**: Understanding of how changes relate

## Usage Examples

### Interactive Mode (`ask`)

```bash
# Set up AI mode
export MAIASS_AI_MODE="ask"
export MAIASS_AI_COMMIT_MESSAGE_STYLE="conventional"

# Run maiass - AI will suggest commit message
maiass patch

# Output:
# 🤖 AI Suggested Commit Message:
# feat: implement user authentication system
# 
# - add JWT token handling
# - create login/logout endpoints
# - update user model with auth fields
#
# Accept this message? (y/n/e for edit): 
```

### Automatic Mode (`autosuggest`)

```bash
# Enable automatic commits (use carefully!)
export MAIASS_AI_MODE="autosuggest"

# AI will commit automatically with generated message
maiass minor
```

## Troubleshooting

### Common Issues

**"OpenAI API key not found"**
- Verify `MAIASS_AI_TOKEN` is set correctly
- Check `.env` file exists and is sourced
- Ensure API key starts with `sk-`

**"API request failed"**
- Check internet connectivity
- Verify API key is valid and has credits
- Try a different model (e.g., `gpt-3.5-turbo`)

**"No changes to analyze"**
- Ensure you have staged changes: `git add .`
- AI needs git diff to generate messages

### Debug Mode

Enable debug output to see AI interaction details:

```bash
export MAIASS_DEBUG="true"
export MAIASS_VERBOSITY="debug"
maiass patch
```

## Best Practices

1. **Start with `ask` mode** - Get familiar with AI suggestions before using `autosuggest`
2. **Review suggestions** - AI is helpful but not perfect
3. **Use appropriate styles** - `conventional` for formal projects, `bullet` for internal work
4. **Stage meaningful changes** - AI works best with focused, logical changesets
5. **Monitor API usage** - OpenAI charges per token, consider costs for heavy usage

## Privacy and Security

- **Code analysis**: Only git diff is sent to OpenAI, not full source code
- **API key security**: Store in `.env` files, never commit to repositories
- **Local processing**: All git operations remain local
- **No data retention**: OpenAI doesn't store your code diffs (per their API policy)
