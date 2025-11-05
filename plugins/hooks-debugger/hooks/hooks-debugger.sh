#!/usr/bin/env bash
# hooks-debugger: Logs all hook events to JSONL files

# 標準入力から JSON を読み取り
input=$(cat)

# タイムスタンプを追加した JSON を作成
logged_at=$(date +"%Y-%m-%dT%H:%M:%S%z")
output=$(jq -c --arg logged_at "$logged_at" '{$logged_at}+.' <<< "$input")

# JSONL ファイルに追記
log_file="${TMPDIR:-/tmp}/claude-hooks-debugger/$(date +"%Y-%m-%d").jsonl"

echo "$output" >> "$log_file" 2>/dev/null
if [[ $? -ne 0 ]]; then
    mkdir -p "${log_file%/*}"
    echo "$output" >> "$log_file"
fi

# 常に正常終了
exit 0
