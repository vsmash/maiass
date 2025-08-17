# 🤖 committhis

**committhis** is a streamlined AI-Augmented Git commit message tool, built for speed and semantic clarity. It uses OpenAI to analyze your changes and generate intelligent, well-formatted commit messages — so you can stay focused on writing code, not prose.

> 🧠 Derived from the full-featured [MAIASS](https://github.com/vsmash/maiass) script, committhis is stripped down to do one thing extremely well: suggest commit messages based on your code diff.
---

## 🚀 Features

- 🔍 Analyzes your staged changes
- 🧠 Uses OpenAI (GPT-4o by default) to suggest commit messages
- ✍️ Outputs messages in configurable styles:
    - `bullet` (default)
    - `conventional`
    - `simple`
    - Custom prompt support
- ⌨️ Supports multi-line editing before committing
- 🧩 Works in any Git repo — just drop it in

---

## 🛠 Installation

You can install `committhis` via Homebrew:

```bash
brew tap vsmash/committhis
brew install committhis
```

Or manually:

```bash
curl -o /usr/local/bin/committhis https://raw.githubusercontent.com/vsmash/committhis/main/committhis.sh
chmod +x /usr/local/bin/committhis
```

---

## 🧪 Usage

```bash
committhis
```

committhis will:

1. Detect your staged changes
2. Ask if you want AI to suggest a commit message
3. Display the message
4. Let you accept, reject, or edit it
5. Commit your changes

> It will **not** bump versions, merge branches, or update changelogs.

---

## ⚙️ Configuration

Set your OpenAI key and preferences via environment variables or a `.env` file in the repo root:

```bash
export MAIASS_AI_TOKEN=your-api-key
export MAIASS_AI_MODE=ask
export MAIASS_AI_COMMIT_MESSAGE_STYLE=bullet
```

Alternatively, create a `.env` file:

```dotenv
MAIASS_AI_TOKEN=your-api-key
MAIASS_AI_MODE=autosuggest
MAIASS_AI_COMMIT_MESSAGE_STYLE=conventional
```

---

## ✨ Prompt Customization

Want full control over the AI prompt?

Create a `.maiass.prompt` file:

```txt
Write a git commit message summarizing the following changes in conventional commit format. Use past tense.

Git diff:
$git_diff
```

---

## 🔐 OpenAI Access

You'll need an OpenAI API key. You can generate one from https://platform.openai.com/account/api-keys and export it as:

```bash
export MAIASS_AI_TOKEN=sk-...
```

---

## 🧼 Clean Design Philosophy

This version does **not**:
- Handle changelogs
- Manage versions
- Create or merge branches
- Require Git Flow

It's a focused tool for intelligent commits — nothing more.

---

## 🧬 Related

- [MAIASS](https://github.com/vsmash/maiass) – the full-fat version with version management, changelogs, and release flow automation.
- [committhis](https://github.com/vsmash/committhis) – this repo.

---

## 📖 License

Licensed under the [GNU GPL v3.0](LICENSE).

---

**Made with ❤️ for my fellow developers who are also crap at writing commit messages and mangaging versioning and changelogs**
## 💸 Support my work

When this tool saves your ass, consider sponsoring mine:

[![GitHub Sponsors](https://img.shields.io/badge/Sponsor-GitHub-ea4aaa?logo=github)](https://github.com/sponsors/vsmash)
[![Ko-fi](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-Ko--fi-29abe0?logo=ko-fi)](https://ko-fi.com/myass)
