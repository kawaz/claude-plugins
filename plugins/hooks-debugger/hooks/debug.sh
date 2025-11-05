#!/usr/bin/env bash
# hooks-debugger: Logs all hook events to JSONL files

# 常に正常終了（Claude の動作を阻害しない）
set +e

# ログディレクトリを作成
LOG_DIR="$HOME/.claude/debug-logs"
mkdir -p "$LOG_DIR" 2>/dev/null || true

# 標準入力から JSON を読み取り
input=$(cat)

# hook_event_name を抽出してファイル名を決定
hook_event_name=$(echo "$input" | jq -r '.hook_event_name // "unknown"' 2>/dev/null || echo "unknown")
log_file="$LOG_DIR/${hook_event_name}.jsonl"

# タイムスタンプを追加した JSON を作成
timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
output=$(echo "$input" | jq -c --arg ts "$timestamp" '. + {logged_at: $ts}' 2>/dev/null || echo "$input")

# JSONL ファイルに追記
echo "$output" >> "$log_file" 2>/dev/null || true

# 常に正常終了
exit 0
