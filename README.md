![MAIASS Banner](https://raw.githubusercontent.com/vsmash/maiass/main/assets/maiassbanner2.png)

<div align="center">
# MAIASS v5.8.16
Modular AI-Augmented Semantic Scribe

---


### 👩‍💻 Are you tired of switching from code-mode to explain-brain?

### 🧑‍💼 Are you sick of opening a repo and finding 20 commits named “fix”?

### 🧠 Wanna keep your code-mode going and leave your explain-brain to ai at commit time?
### 🌟 You deserve structure.
### 🚀 You deserve changelogs. 
### You deserve MAIASS
___
### AI Commit Messages
### Automated Changelogs * Versioning 
### 🫏 YOU can get it all from MAIASS
#### You want MAIASS
#### You deserve MAIASS
Deep down in places you don’t talk about at parties, you *knead MAIASS*

You can't beat **MAIASS**

___
</div>

**MAIASS** (Modular AI-Augmented Semantic Scribe) is an intelligent Git workflow automation script that streamlines version management, changelog generation, and deployment processes with optional AI-powered commit message suggestions.

## Key Features

- **Intelligent Version Management**: Automatic semantic versioning with support for multiple file formats
- **AI-Powered Commit Messages**: Optional OpenAI integration for intelligent commit message generation
- **Automated Changelog Generation**: Keep your project history organized and professional
- **Multi-Platform Git Integration**: Works with GitHub, Bitbucket, and any Git repository
- **Flexible Workflow Support**: Adapts to Git Flow, GitHub Flow, or custom branching strategies
- **Pull Request Automation**: Automatic PR URL generation and browser integration
- **Jira Integration**: Automatic ticket detection and inclusion in commits
- **Cross-Platform Compatibility**: macOS, Linux, and Windows (WSL/Git Bash)

## Quick Start

### Installation

**Homebrew (Recommended)**:
```bash
brew tap vsmash/homebrew-maiass
brew install maiass
```

**Manual Installation**:
```bash
git clone https://github.com/vsmash/maiass.git
cd maiass && ./install.sh
```

This will install both `maiass.sh` (symlinked as `maiass`, `myass`, and `miass`) and `committhis.sh` (symlinked as `committhis`) to your `~/.local/bin` directory if present.

### Basic Usage

```bash
# 5.5.2
maiass

# 5.5.2
maiass minor

# 5.5.2
maiass major

# 5.5.2
maiass 2.1.0

# 5.5.2
# 5.5.2
committhis
* committhis is already integrated into maiass. this is only 
for people who want to use the commit functionality on its 
own without the git flow, version managment and changelog generation

```

### AI-Powered Commit Messages

```bash
# 5.5.2
export MAIASS_AI_TOKEN="your_api_key"
export MAIASS_AI_MODE="ask"

# 5.5.2
maiass patch
```

## Documentation

| Topic | Description |
|-------|-------------|
| **[Installation Guide](docs/installation.md)** | Detailed installation instructions and prerequisites |
| **[Configuration](docs/configuration.md)** | Environment variables and project setup |
| **[AI Integration](docs/ai-integration.md)** | OpenAI setup and AI-powered features |
| **[Version Management](docs/versioning.md)** | Version file formats and semantic versioning |
| **[Pull Requests](docs/prs.md)** | GitHub/Bitbucket integration and workflows |
| **[Advanced Usage](docs/advanced.md)** | Complex workflows and enterprise features |
| **[Changelog Management](docs/changelogging.md)** | Automatic changelog generation and formatting |
| **[FAQ](docs/faq.md)** | Frequently asked questions and common scenarios |
| **[Troubleshooting](docs/troubleshooting.md)** | Common issues and debugging guide |

## 🎯 What Makes MAIASS Special?

### Intelligent Automation
- **Smart Version Detection**: Automatically finds and updates version files in any format
- **Context-Aware AI**: Analyzes your code changes to suggest meaningful commit messages
- **Adaptive Workflows**: Works with your existing Git branching strategy

### Developer Experience
- **Zero Configuration**: Works out of the box with sensible defaults
- **Flexible Setup**: Customize everything through environment variables
- **Rich Feedback**: Clear, actionable output with optional verbose modes

### Enterprise Ready
- **Security First**: API keys never stored in repositories
- **CI/CD Integration**: Perfect for automated deployment pipelines
- **Team Collaboration**: Consistent workflows across development teams

## 🔧 Supported Technologies

### Version File Formats
- **package.json** (Node.js/npm projects)
- **VERSION** files (plain text)
- **Custom formats** (WordPress themes, PHP projects, etc.)
- **Git tags only** (for projects without version files)

### Git Platforms
- **GitHub** (public and private repositories)
- **Bitbucket** (Cloud and Server)
- **Any Git host** (core features work universally)

### AI Models
- **GPT-4o** (recommended for complex projects)
- **GPT-4** (balanced performance and cost)
- **GPT-3.5-turbo** (fast and economical)

## 🌍 Platform Support

| Platform | Status     | Notes |
|----------|------------|-------|
| **macOS** | ✅ Fully Supported | Native Homebrew installation |
| **Linux** | ✅ Fully Supported | All distributions |
| **Windows WSL** | ⚠️ Untested| Recommended for Windows users |
| **Git Bash** | ⚠️ Limited Testing | Basic functionality works |

## 🤝 Contributing

We welcome contributions! Whether it's:
- 🐛 **Bug reports** and feature requests
- 📖 **Documentation** improvements
- 🔧 **Code contributions** and enhancements
- 💡 **Ideas** for new features

Check out our [contribution guidelines](CONTRIBUTING.md) to get started.

## 📄 License

MAIASS is released under the [GNU General Public License v3.0](LICENSE). Free and open source software.

## 🔗 Links

- **[GitHub Repository](https://github.com/vsmash/maiass)**
- **[Issue Tracker](https://github.com/vsmash/maiass/issues)**
- **[Discussions](https://github.com/vsmash/maiass/discussions)**
- **[Homebrew Formula](https://github.com/vsmash/homebrew-maiass)**

---

**Ready to streamline your Git workflow?** Install MAIASS today and experience intelligent version management with AI-powered automation.

```bash
brew tap vsmash/homebrew-maiass && brew install maiass
```

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- 📖 **Documentation**: Check this README and `maiass --help`
- 🐛 **Issues**: Report bugs via GitHub Issues (include OS/shell info)
- 💡 **Feature Requests**: Submit enhancement ideas
- 🤔 **Questions**: Start a GitHub Discussion
- 🪟 **Windows Users**: Use WSL or Git Bash for compatibility

## 🙏 Acknowledgments

- OpenAI for GPT integration
- Git community for workflow inspiration
- All contributors and testers

---

**Made with ❤️ for my fellow developers who are also crap at writing commit messages and mangaging versioning and changelogs**
## 💸 Support MAIASS

When this tool saves your ass, consider sponsoring mine:

[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-ea4aaa?logo=github)](https://github.com/sponsors/vsmash)
[![Ko-fi](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-Ko--fi-29abe0?logo=ko-fi)](https://ko-fi.com/myass)
