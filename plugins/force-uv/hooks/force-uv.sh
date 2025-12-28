#!/bin/bash
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
# コマンドチェックの際に複数行がある場合は最初の行のみを使用
command=$(jq -r '.tool_input.command // empty' <<< "$input")

# 引用符以降は無視する（コミットメッセージとかのコメント文字列に含む場合などの誤検知回避のため）
command=${command%%[\'\"]*}

# コマンドが空の場合は何もチェックしない
[[ -z "$command" ]] && exit 0

# コマンド区切りパターン（行頭 or シェル区切り文字の後）
CMD_PREFIX='(^|[|&;({][[:space:]]*)'

# UV に置き換えを推奨
if [[ $command =~ ${CMD_PREFIX}pip3?.*\ install([[:space:]]|$) ]]; then
    suggest_deny "Use 'uv add' instead of pip install"
fi

if [[ $command =~ ${CMD_PREFIX}python.*\ -m\ venv([[:space:]]|$) ]]; then
    suggest_deny "Use 'uv init' instead of python -m venv"
fi

if [[ $command =~ ${CMD_PREFIX}virtualenv([[:space:]]|$) ]]; then
    suggest_deny "Use 'uv venv' instead of virtualenv"
fi

if [[ $command =~ ${CMD_PREFIX}pipx([[:space:]]|$) ]]; then
    suggest_deny "Use 'uvx' instead of pipx"
fi

exit 0
