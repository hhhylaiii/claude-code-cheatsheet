# My Claude Code Config

> Last update：2026-04-01

---

## `~/.claude/settings.json`

```json
{
  "statusLine": {
    "type": "command",
    "command": "bash /Users/YOUR_USERNAME/.claude/statusline-command.sh"
  },
  "hooks": {
    "Notification": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "osascript -e 'display notification \"Your approval is needed!\" with title \"Claude Code\"'"
          }
        ]
      }
    ],
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          {
            "type": "command",
            "command": "osascript -e 'display notification \"Task completed!\" with title \"Claude Code\"'"
          }
        ]
      }
    ]
  }
}
```

| 設定 | 說明 |
|------|------|
| `statusLine` | 自訂狀態列，執行外部腳本輸出內容 |
| `hooks.Notification` | Claude 需要使用者確認時觸發 macOS 通知 |
| `hooks.Stop` | 每次 Claude 回應結束時觸發 macOS 通知 |

> 注意：`statusLine.command` 裡的路徑需改成你自己的使用者目錄。

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

全域行為指引，對所有專案生效：

```markdown
- Always reply in Traditional Chinese (繁體中文).
- Always write git commit messages in English.
- After modifying any code, automatically suggest a git commit message in English based on the changes made.
- When creating git commits, do NOT add "Co-Authored-By: Claude" or any Claude-related information to the commit message.
```

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
