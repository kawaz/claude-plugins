---
paths:
  - plugins/**/hooks/hooks.json
---

# hooks.json 編集ルール

コマンドパスには `${CLAUDE_PLUGIN_ROOT}` を使用すること。

フックはプロジェクトルート（`$CLAUDE_PROJECT_DIR`）で実行されるため、相対パスではスクリプトを見つけられない。

```json
// OK
"command": "${CLAUDE_PLUGIN_ROOT}/hooks/script.sh"

// NG
"command": "./hooks/script.sh"
```

## 利用可能な環境変数

- `${CLAUDE_PLUGIN_ROOT}` - プラグインディレクトリの絶対パス（プラグインのフックでのみ利用可能）
- `$CLAUDE_PROJECT_DIR` - プロジェクトのルートディレクトリの絶対パス
- `$CLAUDE_ENV_FILE` - 環境変数を永続化するファイルパス（SessionStart フックでのみ利用可能）
