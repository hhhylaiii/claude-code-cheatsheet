# My claude code setting

> Last update：2026-03-31

---

## `~/.claude/settings.json`

目前使用預設值，尚未自訂。

```json
{}
```

若要自訂，可加入以下常用欄位：

```json
{
  "theme": "dark",
  "preferredNotifChannel": "terminal",
  "autoUpdates": true
}
```

---

## `~/.claude/CLAUDE.md`

目前為空。這個檔案用來設定全域的 Claude 行為指引（對所有專案生效）。

範例內容：

```markdown
# Global Instructions

- 回答時請使用繁體中文
- 不要在回應結尾加上總結
- 程式碼優先簡潔，不要過度抽象
```

> 專案層級可在 `<project-root>/CLAUDE.md` 覆寫這些設定

---

## `~/.claude/keybindings.json`

目前未建立（使用預設快捷鍵）。

若要自訂，建立 `~/.claude/keybindings.json`：

```json
{
  "bindings": [
    {
      "context": "Chat",
      "bindings": {
        "ctrl+e": "chat:externalEditor"
      }
    }
  ]
}
```

---

## Plugins

使用官方 marketplace：`anthropics/claude-plugins-official`

目前無安裝任何 plugin。

安裝 plugin 指令：

```bash
/plugin install <plugin-name>
```

---

## 環境說明

| 項目 | 值 |
|------|-----|
| 平台 | macOS (darwin) |
| Shell | zsh |
| 設定目錄 | `~/.claude/` |
