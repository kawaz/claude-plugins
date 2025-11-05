# Kawaz's Claude Plugins

A collection of useful Claude Code plugins.

## Installation

### 1. Add Marketplace

First, add this marketplace to Claude Code:

```bash
/plugin marketplace add kawaz/claude-plugins
```

### 2. Install Plugins

Then install the plugins you want:

```bash
# Install all plugins
/plugin install force-japanese@kawaz-plugins
/plugin install force-bun@kawaz-plugins
/plugin install force-uv@kawaz-plugins
/plugin install hooks-debugger@kawaz-plugins

# Or install specific ones
/plugin install force-japanese@kawaz-plugins
```

After installation, restart Claude Code to activate the plugins.

## Available Plugins

- **[force-japanese](./plugins/force-japanese)** - Forces Japanese language even after SessionStart:compact resets
- **[force-bun](./plugins/force-bun)** - Suggests Bun instead of npm/npx commands
- **[force-uv](./plugins/force-uv)** - Suggests UV instead of pip/pipx/venv commands
- **[hooks-debugger](./plugins/hooks-debugger)** - Logs all hook events to JSONL files for debugging

## Development

See [CLAUDE.md](./CLAUDE.md) for plugin development guidelines.

### Repository Structure

```
kawaz/claude-plugins/
├── .claude-plugin/
│   └── marketplace.json
├── plugins/
│   ├── force-japanese/
│   ├── force-bun/
│   ├── force-uv/
│   └── hooks-debugger/
├── CLAUDE.md
└── README.md
```

## License

MIT

## Author

kawaz - https://github.com/kawaz
