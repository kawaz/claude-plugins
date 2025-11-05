#!/usr/bin/env bash
# hooks-debugger: Logs all hook events to JSONL files

# ログディレクトリとファイルパスを初期化
log_dir="${TMPDIR:-/tmp}/claude-hooks-debugger"
log_file="$log_dir/$(date +"%Y-%m-%d").jsonl"

# 標準入力から JSON を読み取り
input=$(cat)

# hook_event_name を抽出
hook_event_name=$(jq -r '.hook_event_name // "unknown"' <<< "$input")

# SessionStart 時に古いログファイルをクリーンアップ（3日以上前のファイルを削除）
if [[ "$hook_event_name" == "SessionStart" ]]; then
    find "$log_dir" -type f -mtime +3 -delete 2>/dev/null
fi

# タイムスタンプを追加した JSON を作成
output=$(jq -c '{logged_at: (now | strflocaltime("%Y-%m-%dT%H:%M:%S%z"))}+.' <<< "$input")

# JSONL ファイルに追記
echo "$output" >> "$log_file" 2>/dev/null
if [[ $? -ne 0 ]]; then
    mkdir -p "$log_dir"
    echo "$output" >> "$log_file"
fi

# 常に正常終了
exit 0
