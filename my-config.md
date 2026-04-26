# My Claude Code Config

> Last updated: 2026-04-26

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
            "command": "node \"/Users/YOUR_USERNAME/.claude/scripts/hooks/notification-permission-filter.js\""
          }
        ]
      }
    ]
  }
}
```

> Note: Replace `YOUR_USERNAME` with your actual username.
> The `Stop` notification is handled by ECC's `stop:desktop-notify` hook (shows task summary).
> The `Notification` hook uses a filter script to avoid false positives — see below.

| Setting | Description |
|---------|-------------|
| `statusLine` | Custom status line — runs an external script and displays its output |
| `hooks.Notification` | Filters notification payloads and only triggers a macOS alert for actual permission requests |

---

## `~/.claude/scripts/hooks/notification-permission-filter.js`

> Last updated: 2026-04-26

The `Notification` event fires for both idle (CC waiting for input) and actual permission requests. Without filtering, every response completion triggers a misleading "Your approval is needed!" alert.

This script parses the notification payload and only shows a macOS notification when approval is genuinely required.

### Filter logic

1. If `type` is `"idle"` / `"waiting"` / `"complete"` → skip (ECC's `stop:desktop-notify` handles completion alerts)
2. If `type` is `"permission"` / `"approval"` → notify
3. Otherwise → keyword scan for `permission`, `approve`, `bash`, `tool use`, etc.

Full script: [`notification-permission-filter.js`](notification-permission-filter.js)

---

## `~/.claude/statusline-command.sh`

Custom status line script. Output format:

```
Context [████░░░░░░] 34% | Usage [█░░░░░░░░░] 9% (4h 41m / 5h) | [██░░░░░░░░] 18% (2d 5h / 7d)
```

Three sections separated by `|`:

| Section | Description |
|---------|-------------|
| Context | Current context window usage percentage |
| Usage (5h) | 5-hour rate limit — elapsed time / 5h |
| Usage (7d) | 7-day rate limit — elapsed time / 7d |

Full script: [`statusline-command.sh`](statusline-command.sh)

---

## `~/.claude/CLAUDE.md`

Global behavior instructions applied to all projects:

```markdown
- Always reply in Traditional Chinese (繁體中文).
- Always write git commit messages in English using the format "type: description", where type is one of: feat, fix, chore, test, docs, refactor, style, perf.
- After modifying any code, automatically suggest a git commit message in English based on the changes made.
- When creating git commits, do NOT add "Co-Authored-By: Claude" or any Claude-related information to the commit message.
- When creating PR descriptions, do NOT include "🤖 Generated with Claude Code" or any Claude-related attribution.
- Always write code comments in English.
```

---

## Tool Routing: Gemini CLI

> Last updated: 2026-04-26

Gemini CLI (`gemini`) is installed locally and used as a lightweight research assistant to offload simple queries from Claude.

### Installation

```bash
# Install Gemini CLI (requires Node.js)
npm install -g @google/gemini-cli

# Verify
gemini --version
```

### Usage (non-interactive / headless)

```bash
gemini -p "your query" -o text
```

### Routing Rule (in `~/.claude/CLAUDE.md`)

| Task type | Handler |
|---|---|
| Web search, fact lookup | Gemini CLI |
| Library / API docs | Gemini CLI |
| Version numbers, changelogs | Gemini CLI |
| Quick syntax / usage examples | Gemini CLI |
| Writing or editing code | Claude |
| Planning / architecture | Claude |
| Debugging, multi-file analysis | Claude |
| Complex reasoning | Claude |

**Fallback:** If `gemini` returns an error (quota exceeded, network failure), Claude handles the task directly.

---

## `~/.claude/keybindings.json`

Not created — using default keybindings.

---

## ECC (everything-claude-code)

> Repo: [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code)
> Installed to: `~/.claude/` (rules, agents, skills, commands, hooks, scripts)

### Installation

```bash
git clone https://github.com/affaan-m/everything-claude-code.git
cd everything-claude-code
npm install
./install.sh --profile full
```

### Environment Variables (add to `~/.zshrc`)

```bash
export ECC_HOOK_PROFILE="standard"   # Enable hooks (minimal / standard / strict)
```

### Hook Overview

ECC installs hooks into `~/.claude/settings.json`:

| Hook Type | Function |
|-----------|----------|
| `PreToolUse` | Block `--no-verify`, tmux reminders, commit quality checks, config file protection |
| `PostToolUse` | Bash command audit log, quality gate, console.log warnings |
| `Stop` | Format/typecheck JS/TS, session persistence, cost tracking, desktop notification with task summary |
| `SessionStart` | Load previous context, detect package manager |
| `SessionEnd` | Session end lifecycle marker |
| `PreCompact` | Save state before context compaction |

---

## Environment

| Item | Value |
|------|-------|
| Platform | macOS (darwin) |
| Shell | zsh |
| Config directory | `~/.claude/` |
| ECC install | full profile (679 files) |
