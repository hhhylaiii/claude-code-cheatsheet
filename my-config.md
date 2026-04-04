# My Claude Code Config

> Last update：2026-04-04

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
    ]
  }
}
```

> 注意：`statusLine.command` 裡的路徑需改成你自己的使用者目錄。
> Stop 通知已由 ECC 的 `stop:desktop-notify` hook 接管（提供含任務摘要的通知）。

| 設定 | 說明 |
|------|------|
| `statusLine` | 自訂狀態列，執行外部腳本輸出內容 |
| `hooks.Notification` | Claude 需要使用者確認時觸發 macOS 通知 |

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
- Always write git commit messages in English using the format "type: description", where type is one of: feat, fix, chore, test, docs, refactor, style, perf.
- After modifying any code, automatically suggest a git commit message in English based on the changes made.
- When creating git commits, do NOT add "Co-Authored-By: Claude" or any Claude-related information to the commit message.
```

---

## `~/.claude/keybindings.json`

目前未建立（使用預設快捷鍵）。

---

## ECC（everything-claude-code）

> Repo：[affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code)
> 安裝路徑：`~/.claude/`（rules、agents、skills、commands、hooks、scripts）

### 安裝方式

```bash
git clone https://github.com/affaan-m/everything-claude-code.git
cd everything-claude-code
npm install
./install.sh --profile full
```

### 環境變數（加入 `~/.zshrc`）

```bash
export ECC_HOOK_PROFILE="standard"   # 啟用 hooks（minimal / standard / strict）
```

### Hook 說明

ECC 安裝後會在 `~/.claude/settings.json` 加入大量 hooks：

| Hook 類型 | 主要功能 |
|-----------|---------|
| `PreToolUse` | 阻擋 `--no-verify`、tmux 提醒、commit 品質檢查、config 保護 |
| `PostToolUse` | Bash 指令日誌、品質門檻、console.log 警告 |
| `Stop` | 格式化/型別檢查（JS/TS）、session 儲存、cost 追蹤、桌面通知 |
| `SessionStart` | 載入先前 context、偵測 package manager |
| `SessionEnd` | Session 結束標記 |
| `PreCompact` | 壓縮前儲存狀態 |

---

## 環境說明

| 項目 | 值 |
|------|-----|
| 平台 | macOS (darwin) |
| Shell | zsh |
| 設定目錄 | `~/.claude/` |
| ECC 版本 | full profile（679 個檔案）|
