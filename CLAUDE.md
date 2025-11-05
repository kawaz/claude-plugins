# Claude Code Plugin Development Guide

このリポジトリのプラグインを開発する際の重要な注意事項とガイドラインです。

## バージョン管理の重要性

プラグインのファイルを更新する際は、**必ずバージョン番号を更新してください**。Claude Code はバージョン番号を見て更新の有無を判断します。

### 更新が必要なファイル

プラグインに変更を加えた場合、以下のファイルのバージョンを更新する必要があります：

#### 1. プラグイン個別の更新の場合

変更したプラグインの `plugin.json` のバージョンを更新：

```
plugins/{plugin-name}/.claude-plugin/plugin.json
```

例：
```json
{
  "name": "hooks-debugger",
  "description": "Logs all hook events to JSONL files for debugging purposes",
  "version": "0.1.2",  // ← ここを更新
  "author": {
    "name": "kawaz"
  }
}
```

#### 2. マーケットプレイス全体の更新の場合

`.claude-plugin/marketplace.json` のバージョンも更新：

```
.claude-plugin/marketplace.json
```

例：
```json
{
  "metadata": {
    "description": "A collection of useful Claude Code plugins by kawaz",
    "version": "0.1.2"  // ← ここを更新
  }
}
```

### バージョン更新を忘れた場合

バージョン番号を更新せずに Git に push しても、Claude Code 側で `/plugin` コマンドを使って更新しても、**古いバージョンのまま**として認識され、実際のファイルが更新されません。

## フックスクリプトのパス指定

`hooks/hooks.json` 内でコマンドを指定する際は、**プラグインのルートディレクトリからの相対パス**で指定してください。

### 正しい例

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "./hooks/force-bun.sh"  // ← プラグインルートからの相対パス
          }
        ]
      }
    ]
  }
}
```

### 間違った例

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "./force-bun.sh"  // ← hooks.json があるディレクトリからの相対パス（NG）
          }
        ]
      }
    ]
  }
}
```

## 開発ワークフロー

1. プラグインのファイルを編集
2. 変更したプラグインの `plugin.json` のバージョンを更新
3. `.claude-plugin/marketplace.json` のバージョンを更新
4. Git にコミット＆プッシュ
5. `/plugin` コマンドでプラグインを更新
6. Claude Code を再起動

## デバッグ

hooks-debugger プラグインを使うと、すべてのフックイベントがログに記録されます：

```bash
cat "${TMPDIR:-/tmp}/claude-hooks-debugger/$(date +%Y-%m-%d).jsonl" | jq
```
