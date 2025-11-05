# force-japanese

Forces Claude Code to use Japanese language even after `SessionStart:compact` resets the language preference.

## Problem it solves

Claude Code sometimes resets the conversation language to English after certain events like `SessionStart:compact`. This plugin ensures Japanese language context is preserved across session resets.

## How it works

The plugin hooks into the `SessionStart` event with matcher `"compact"` and injects "チャットは日本語。" context, instructing Claude to communicate in Japanese.

## Installation

```bash
/plugin marketplace add kawaz/claude-plugins
/plugin install force-japanese@kawaz-claude-plugins
```

## Configuration

No configuration required. The plugin automatically activates on SessionStart:compact events.
