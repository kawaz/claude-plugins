# Kawaz's Claude Plugins

A collection of useful Claude Code plugins.

## Installation

```bash
# Add marketplace
/plugin marketplace add kawaz/claude-plugins

# Install plugins (see each plugin's README for details)
/plugin install <plugin-name>@kawaz-claude-plugins
```

## Available Plugins

- **[force-japanese](./plugins/force-japanese)** - Forces Japanese language even after SessionStart:compact resets
- **[force-bun](./plugins/force-bun)** - Suggests Bun instead of npm/npx commands
- **[force-uv](./plugins/force-uv)** - Suggests UV instead of pip/pipx/venv commands
- **[hooks-debugger](./plugins/hooks-debugger)** - Logs all hook events to JSONL files for debugging
- **[claude-session-analysis](https://github.com/kawaz/claude-session-analysis)** - Analyze session files to view timeline, file operations, and version diffs

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
