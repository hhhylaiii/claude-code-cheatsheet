# My Claude Code Config

> Last update：2026-04-01

---

## `~/.claude/settings.json`

```json
{
  "statusLine": {
    "type": "command",
    "command": "bash /Users/hhhylaiii/.claude/statusline-command.sh"
  }
}
```

> 注意：`command` 裡的路徑需改成你自己的使用者目錄。

---

## `~/.claude/statusline-command.sh`

自訂狀態列腳本，顯示格式如下：

```
Context [████░░░░░░] 34% | Usage [█░░░░░░░░░] 9% (4h 41m / 5h) | [██░░░░░░░░] 18% (2d 5h / 7d)
```

三個區塊，以 `|` 分隔：

| 區塊 | 說明 |
|------|------|
| Context | 目前 context window 使用百分比 |
| Usage (5h) | 5 小時用量限制，顯示已用時間 / 5h |
| Usage (7d) | 7 天用量限制，顯示已用時間 / 7d |

完整腳本見 [`statusline-command.sh`](statusline-command.sh)。

---

## `~/.claude/CLAUDE.md`

目前為空。這個檔案用來設定全域的 Claude 行為指引（對所有專案生效）。

---

## `~/.claude/keybindings.json`

目前未建立（使用預設快捷鍵）。

---

## 環境說明

| 項目 | 值 |
|------|-----|
| 平台 | macOS (darwin) |
| Shell | zsh |
| 設定目錄 | `~/.claude/` |
