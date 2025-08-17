# Frequently Asked Questions

## General Questions

### What does MAIASS stand for?
MAIASS stands for **Modular AI-Augmented Semantic Scribe**. It's a Git workflow automation script that intelligently handles version bumping, changelog management, and AI-powered commit messages.

### How do you pronounce it?
However you would like to. I hope it introduces some mirth to your day on a regular basis.

### What platforms does MAIASS support?
MAIASS is designed for Unix-like environments:
- **macOS** (fully supported)
- **Linux** (all distributions)

### 🪟 What about Windows?
This is not tested in Windows environments but I immediately realise that there would be issues with slashes and unicode. 
Considering doing a powershell equivalent but no promises.
- **Windows with WSL** (untested)
- **Git Bash on Windows** (untested)

### Do I need an OpenAI API key to use MAIASS?
No, the OpenAI integration is optional. MAIASS works perfectly without AI features:
- **With AI**: Get intelligent commit message suggestions
- **Without AI**: Manual commit message entry (traditional workflow)

## Installation & Setup

### How do I install MAIASS?
There are two main methods:
1. **Homebrew (recommended)**: `brew tap vsmash/homebrew-maiass && brew install maiass`
2. **Manual installation**: Clone the repo and run `./install.sh`

### What dependencies does MAIASS require?
- **Bash** 3.2+ (macOS default bash works)
- **ZHS** It's a bash shebang, so it will just use bash instead
- **Git** command-line tools
- **jq** JSON processor (install with `brew install jq` or `apt install jq`)
- Standard Unix utilities (`grep`, `sed`, `awk`)

### How do I configure MAIASS for my project?
Defaults are out of the box, but you can *override* variables per project by using `.env` file.
Create a `.env` file in your project root with your preferred settings:
```bash
# Basic configuration
MAIASS_MASTERBRANCH=main
MAIASS_AI_MODE=autosuggest
```
You can also set global overrides and your openai token in your home directory in `.maiass.env`
The `.env` file takes precedence over the `.maiass.env` file.

## Version Management

### What version file formats does MAIASS support?
- **package.json** (Node.js projects)
- **VERSION** files (plain text)
- **Custom files** with configurable patterns

### Can I use MAIASS with non-standard version files?
Yes! MAIASS supports a flexible version file system:
```bash
# WordPress theme example
MAIASS_VERSION_PRIMARY_FILE="style.css"
MAIASS_VERSION_PRIMARY_TYPE="txt"
MAIASS_VERSION_PRIMARY_LINE_START="Version: "
```

### How does MAIASS handle semantic versioning?
MAIASS follows [Semantic Versioning](https://semver.org/):
- `maiass` or `maiass patch`: 1.2.3 → 1.2.4
- `maiass minor`: 1.2.3 → 1.3.0
- `maiass major`: 1.2.3 → 2.0.0
- `maiass 2.1.0`: Set specific version

## Git Workflows

### What Git workflows does MAIASS versioning support?
Changelogging is dependent on versioning, and supports the following workflows:
- **Git Flow**: feature → develop → staging → master
- **GitHub Flow**: feature → main
- **Custom workflows**: Any branch structure
- **Local-only**: Works without remotes
If you are not using changelogging, you can still use MAIASS to:
- Bump versions
- Tag commits
- Generate commit messages using AI

### What if my repository doesn't have a main branch?
No problem! MAIASS gracefully handles missing branches:
- Skips missing branch operations
- Adapts workflow to available branches
- Works with single-branch repositories

### What if my repository doesn't have a develop branch?
No problem! MAIASS gracefully handles missing branches:
- Skips missing branch operations
- Adapts workflow to available branches
- Works with single-branch repositories

### Can I use MAIASS with repositories that have no remote?
Yes! MAIASS works perfectly with local-only repositories:
- Performs all operations locally
- Skips push/pull operations
- Creates local tags and updates files

## AI Features

### How do I set up AI commit messages?
1. Get an OpenAI API key from [platform.openai.com](https://platform.openai.com/)
2. Add to your `.env` in your project: `MAIASS_AI_TOKEN=your_key_here`, or in your shell profile: `export MAIASS_AI_TOKEN="your_key_here", or in your home directory in `.maiass.env`
3. Set mode: `MAIASS_AI_MODE=autosuggest`. The default mode is 'ask' which will prompt you for approval.
4. Set model: `MAIASS_AI_MODEL=gpt-3.5-turbo`. The default model is 'gpt-4o'.
5. Set commit message style: `MAIASS_AI_COMMIT_MESSAGE_STYLE=bullet`. The default style is 'bullet'.

### What AI modes are available?
- **`off`**: No AI assistance
- **`ask`**: AI suggests, you approve/edit (ask)
- **`autosuggest`**: AI commits automatically (if you are not wary about credits)

### What commit message styles does the AI support?
- **`bullet`**: Bulleted list format (default)
- **`conventional`**: Conventional Commits format
- **`simple`**: Simple descriptive messages

### How much does the AI feature cost?
Costs depend on OpenAI's pricing:
- **GPT-4o**: ~$0.01-0.03 per commit message
- **GPT-3.5-turbo**: ~$0.001-0.003 per commit message
- Only git diff is sent, not full source code

## Repository Compatibility

### Does MAIASS work with GitHub?
Yes! MAIASS automatically:
- Detects GitHub repositories
- Generates pull request URLs
- Extracts owner/repo information
- Works with private repositories

### Does MAIASS work with Bitbucket?
Yes! MAIASS supports:
- Bitbucket Cloud and Server
- Automatic workspace/repo detection
- Pull request URL generation
- Private repositories

### Can I use MAIASS with GitLab or other Git hosts?
MAIASS works with any Git repository, but:
- **Pull request integration**: Only GitHub/Bitbucket
- **Core features**: Work with any Git host
- **Version management**: Universal compatibility

## Troubleshooting

### MAIASS says "command not found"
- Restart your terminal after installation
- Source your shell profile: `source ~/.zshrc` or `source ~/.bashrc`
- Check if MAIASS is in your PATH: `which maiass`

### "jq: command not found" error
Install jq JSON processor:
```bash
# macOS
brew install jq

# Ubuntu/Debian
sudo apt install jq

# CentOS/RHEL
sudo yum install jq
```

### Version files aren't being updated
- Check file permissions (write access)
- Verify file path in configuration
- Test with debug mode: `MAIASS_DEBUG=true maiass patch`

### AI features aren't working
- Verify API key is set: `echo $MAIASS_AI_TOKEN`
- Check internet connectivity
- Ensure you have OpenAI credits
- Try a different model: `MAIASS_AI_MODEL=gpt-3.5-turbo`

## Advanced Usage

### Can I customize the output verbosity?
Yes! Set the verbosity level:
- **`brief`**: Essential messages only (default)
- **`normal`**: Detailed progress information
- **`debug`**: All operations and debug info

```bash
export MAIASS_VERBOSITY="normal"
```

### How do I enable logging?
```bash
export MAIASS_LOGGING="true"
export MAIASS_LOG_FILE="maiass.log"
```

### Can I use MAIASS in CI/CD pipelines?
No. MAIASS is an interactive command-line tool and should not be used in CI/CD pipelines. There is no non-interactive mode at this stage.

### How do I handle multiple version files?
Use the secondary files configuration:
`filepathandname:filetype:pattern`
```bash
MAIASS_VERSION_SECONDARY_FILES="README.md:txt:Version |config.yml:txt:version: "
```
file types: `txt`, `json`, `php`
txt replaces the end of the line after your specified pattern
php uses regex to find your defined pattern
json uses jq to find your defined pattern

## Best Practices

### What's the recommended workflow for new users?
1. Start with basic usage: `maiass patch`
2. Configure branch names in `.env` if needed.
3. Try AI features with `ask` mode
4. Gradually customize for your project needs

### How should I structure my branches for MAIASS?
MAIASS adapts to your structure, but common patterns work well:
- **Git Flow**: `main`/`master`, `staging`, `develop`, `feature/*`, `release/*`
- **GitHub Flow**: `main`, `feature/*`
- **Custom**: Any consistent naming convention

### Should I commit the .env file?
**No!** Add `.env` to your `.gitignore`:
- Contains sensitive API keys
- Project-specific configurations
- Use `.env.example` for team sharing

## Integration

### Does MAIASS integrate with Jira?
Yes! MAIASS automatically:
- Detects ticket numbers from branch names
- Includes tickets in commit messages
- Example: `feature/PROJ-123-login` → `[PROJ-123]` in commits

### Can I use MAIASS with pre-commit hooks?
Yes in theory but not tested. Feel free to contribute to this aspect of the MIASS project.
Be careful with:
- Interactive prompts in hooks
- AI API calls in automated environments
- Consider using non-interactive modes

### Does MAIASS work with monorepos?
MAIASS works in monorepos but:
- Operates on the entire repository
- Version management affects the whole repo
- Consider separate configurations per package

## Getting Help

### Where can I find more documentation?
- **Installation**: [docs/installation.md](installation.md)
- **Configuration**: [docs/configuration.md](configuration.md)
- **AI Integration**: [docs/ai-integration.md](ai-integration.md)
- **Version Management**: [docs/versioning.md](versioning.md)

### How do I report bugs or request features?
- **GitHub Issues**: [github.com/vsmash/maiass/issues](https://github.com/vsmash/maiass/issues)
- **Discussions**: [github.com/vsmash/maiass/discussions](https://github.com/vsmash/maiass/discussions)

### How do I contribute to MAIASS?
- Fork the repository
- Create a feature branch
- Submit a pull request
- Follow the contribution guidelines
