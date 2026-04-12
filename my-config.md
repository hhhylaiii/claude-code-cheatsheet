# My Claude Code Config

> Last updated: 2026-04-12

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

> Note: Replace `YOUR_USERNAME` in `statusLine.command` with your actual username.
> The `Stop` notification is now handled by ECC's `stop:desktop-notify` hook, which includes a task summary.

| Setting | Description |
|---------|-------------|
| `statusLine` | Custom status line — runs an external script and displays its output |
| `hooks.Notification` | Triggers a macOS notification when Claude needs user approval |

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
