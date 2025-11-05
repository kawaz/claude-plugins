#!/usr/bin/env bash
set -euo pipefail

suggest_deny() {
    local reason="$1"
    jq -cn \
        --arg reason "$reason" \
        '{
            "hookSpecificOutput": {
                "hookEventName": "PreToolUse",
                "permissionDecision": "deny",
                "permissionDecisionReason": $reason
            }
        }'
    exit 1
}

# 標準入力から JSON を読み取り
input=$(</dev/stdin)
command=$(echo "$input" | jq -r '.tool_input.command // empty')

# コマンドが空の場合は何もチェックしない
[[ -z "$command" ]] && exit 0

# UV に置き換えを推奨
if [[ $command =~ pip3?.*\ install ]]; then
    suggest_deny "Use 'uv add' instead of pip install"
fi

if [[ $command =~ python.*\ -m\ venv ]]; then
    suggest_deny "Use 'uv init' instead of python -m venv"
fi

if [[ $command =~ virtualenv ]]; then
    suggest_deny "Use 'uv venv' instead of virtualenv"
fi

if [[ $command =~ pipx ]]; then
    suggest_deny "Use 'uvx' instead of pipx"
fi

exit 0
