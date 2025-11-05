# force-uv

Suggests using UV instead of pip/pipx/venv commands when Claude tries to use them in Bash tool calls.

## Problem it solves

Claude Code often defaults to using pip, virtualenv, or pipx for Python package management. If you prefer using UV for its speed and modern workflow, this plugin will intercept those commands and suggest UV alternatives.

## How it works

The plugin hooks into the `PreToolUse` event for Bash tool calls and checks if the command contains pip/pipx/venv-related commands. If found, it denies the action and suggests the UV equivalent:

- `pip install` / `pip3 install` → `uv add`
- `python -m venv` → `uv init`
- `virtualenv` → `uv venv`
- `pipx` → `uvx`

## Installation

```bash
/plugin marketplace add kawaz/claude-plugins
/plugin install force-uv@kawaz-claude-plugins
```

## Configuration

No configuration required. The plugin automatically intercepts pip/pipx/venv commands in Bash tool calls.
