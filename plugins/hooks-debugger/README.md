# hooks-debugger

Logs all hook events to JSONL files for debugging and development purposes.

## Problem it solves

When developing plugins or debugging hook behavior, it's useful to see exactly what data is being passed to hooks. This plugin captures all hook events and saves them to files for inspection.

## How it works

The plugin hooks into all 9 available hook events and logs the complete input JSON to daily JSONL files. Each log entry includes a timestamp. The plugin always exits successfully (exit 0) so it never interferes with Claude's normal operation. Log files older than 3 days are automatically cleaned up.

## Supported hook events

- `SessionStart` - Session initialization/resumption
- `SessionEnd` - Session termination
- `PreToolUse` - Before tool execution
- `PostToolUse` - After tool execution
- `PreCompact` - Before conversation compaction
- `UserPromptSubmit` - When user submits prompts
- `Notification` - Claude Code notifications
- `Stop` - Main agent response completion
- `SubagentStop` - Subagent (Task tool) completion

## Installation

```bash
/plugin marketplace add kawaz/claude-plugins
/plugin install hooks-debugger@kawaz-claude-plugins
```

## Usage

View today's logs:

```bash
cat "${TMPDIR:-/tmp}/claude-hooks-debugger/$(date +%Y-%m-%d).jsonl" | jq
```

View specific hook events:

```bash
# Filter by hook event name
cat "${TMPDIR:-/tmp}/claude-hooks-debugger/$(date +%Y-%m-%d).jsonl" | jq 'select(.hook_event_name == "PreToolUse")'

# View user prompts
cat "${TMPDIR:-/tmp}/claude-hooks-debugger/$(date +%Y-%m-%d).jsonl" | jq 'select(.hook_event_name == "UserPromptSubmit") | .prompt'

# View tool usage
cat "${TMPDIR:-/tmp}/claude-hooks-debugger/$(date +%Y-%m-%d).jsonl" | jq 'select(.hook_event_name == "PreToolUse") | {tool_name, tool_input}'
```

## Log file location

- `${TMPDIR:-/tmp}/claude-hooks-debugger/YYYY-MM-DD.jsonl`

Log files are automatically cleaned up after 3 days.
