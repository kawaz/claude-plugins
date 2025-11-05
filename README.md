# Kawaz's Claude Plugins

A collection of useful Claude Code plugins.

## Installation

### Add Marketplace

```bash
/plugin marketplace add kawaz/claude-plugins
```

### Install Plugins

```bash
# Install specific plugins
/plugin install force-japanese@kawaz-plugins
/plugin install force-bun@kawaz-plugins
/plugin install force-uv@kawaz-plugins
```

## Available Plugins

### force-japanese

Forces Claude Code to use Japanese language even after `SessionStart:compact` resets the language preference.

**Problem it solves:**
Claude Code sometimes resets the conversation language to English after certain events like `SessionStart:compact`. This plugin ensures Japanese language context is preserved across session resets.

**How it works:**
The plugin hooks into the `SessionStart` event and injects "チャットは日本語。" context, instructing Claude to communicate in Japanese.

**Installation:**
```bash
/plugin install force-japanese@kawaz-plugins
```

### force-bun

Suggests using Bun instead of npm/npx commands when Claude tries to use them in Bash tool calls.

**Problem it solves:**
Claude Code often defaults to using npm/npx commands. If you prefer using Bun for its speed and modern features, this plugin will intercept those commands and suggest Bun alternatives.

**How it works:**
The plugin hooks into the `PreToolUse` event for Bash tool calls and checks if the command contains npm/npx. If found, it denies the action and suggests the Bun equivalent:
- `npx` → `bunx`
- `npm install` → `bun install`
- `npm run` → `bun run`
- etc.

**Installation:**
```bash
/plugin install force-bun@kawaz-plugins
```

### force-uv

Suggests using UV instead of pip/pipx/venv commands when Claude tries to use them in Bash tool calls.

**Problem it solves:**
Claude Code often defaults to using pip, virtualenv, or pipx for Python package management. If you prefer using UV for its speed and modern workflow, this plugin will intercept those commands and suggest UV alternatives.

**How it works:**
The plugin hooks into the `PreToolUse` event for Bash tool calls and checks if the command contains pip/pipx/venv-related commands. If found, it denies the action and suggests the UV equivalent:
- `pip install` → `uv add`
- `python -m venv` → `uv init`
- `virtualenv` → `uv venv`
- `pipx` → `uvx`

**Installation:**
```bash
/plugin install force-uv@kawaz-plugins
```

## Development

### Repository Structure

```
kawaz/claude-plugins/
├── .claude-plugin/
│   └── marketplace.json           # Marketplace definition
├── plugins/
│   ├── force-japanese/            # Japanese language plugin
│   │   ├── plugin.json
│   │   └── hooks/
│   │       └── session-start.sh
│   ├── force-bun/                 # Bun enforcement plugin
│   │   ├── plugin.json
│   │   └── hooks/
│   │       └── pre-tool-use.sh
│   └── force-uv/                  # UV enforcement plugin
│       ├── plugin.json
│       └── hooks/
│           └── pre-tool-use.sh
└── README.md
```

### Adding New Plugins

1. Create a new directory under `plugins/`
2. Add `plugin.json` with plugin metadata
3. Implement hooks or other plugin features
4. Update this README

## License

MIT

## Author

kawaz - https://github.com/kawaz
