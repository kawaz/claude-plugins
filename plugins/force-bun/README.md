# force-bun

Suggests using Bun instead of npm/npx commands when Claude tries to use them in Bash tool calls.

## Problem it solves

Claude Code often defaults to using npm/npx commands. If you prefer using Bun for its speed and modern features, this plugin will intercept those commands and suggest Bun alternatives.

## How it works

The plugin hooks into the `PreToolUse` event for Bash tool calls and checks if the command contains npm/npx. If found, it denies the action and suggests the Bun equivalent:

- `npx` → `bunx`
- `npm install` → `bun install`
- `npm run` → `bun run`
- etc.

Note: `npm version` is allowed since it has no Bun equivalent.

## Installation

```bash
/plugin marketplace add kawaz/claude-plugins
/plugin install force-bun@kawaz-plugins
```

## Configuration

No configuration required. The plugin automatically intercepts npm/npx commands in Bash tool calls.
