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

# Bun に置き換えを推奨
if [[ $command =~ (^| )(npx|npm\ x|npm\ exec)( ) ]]; then
    suggest_deny "Use 'bunx' instead of npx, npm x, or npm exec"
fi

# npm version は許可
if [[ $command =~ npm\ version ]]; then
    exit 0
fi

# その他の npm コマンドは Bun を推奨
if [[ $command =~ (^| )npm( ) ]]; then
    suggest_deny "Use 'bun' instead of npm"
fi

exit 0
