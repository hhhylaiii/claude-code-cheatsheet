# Claude Code Terminal Cheatsheet

> Quick reference for common operations. Full documentation at [official docs](https://docs.anthropic.com/en/docs/claude-code).

Personal configuration notes: [my-config.md](my-config.md).

---

## Starting Claude Code

```bash
claude                        # Open interactive mode
claude "prompt"               # Open with initial prompt
claude -p "prompt"            # Non-interactive mode, print result and exit
cat file.txt | claude -p "prompt"  # Process piped input
claude -c                     # Continue the most recent conversation
claude -r "session-name"      # Resume a specific session
```

---

## CLI Flags

| Flag | Description |
|------|-------------|
| `-c, --continue` | Continue the most recent conversation in the current directory |
| `-r, --resume` | Resume a specific session (by ID or name) |
| `--model` | Specify model (e.g. `sonnet`, `opus`) |
| `-p, --print` | Non-interactive mode, exit after output |
| `--output-format` | Output format: `text`, `json`, `stream-json` |
| `--max-turns N` | Limit max agentic turns (use with `-p`) |
| `--permission-mode` | Set permission mode on launch (`plan`, `auto`, `default`) |
| `--add-dir <path>` | Add extra working directory |
| `--verbose` | Verbose log output |
| `--version` | Show version number |

---

## Input Prefixes

| Prefix | Description |
|--------|-------------|
| `/` | Run a slash command or skill |
| `!` | Execute a bash command directly (bypasses Claude) |
| `@` | Reference a file path (with autocomplete) |

---

## Built-in Slash Commands

| Command | Description |
|---------|-------------|
| `/help` | Show help |
| `/clear` | Start a new session |
| `/resume` | Resume a previous session |
| `/memory` | View/edit CLAUDE.md and memory |
| `/settings` | Open settings menu |
| `/hooks` | Manage hooks |
| `/cost` | View API usage cost |
| `/doctor` | Diagnose issues |
| `/vim` | Enable vim editing mode |
| `/terminal-setup` | Configure terminal (e.g. enable Shift+Enter newline) |
| `/commit` | Create a git commit |
| `/compact` | Compress conversation history to save context |

---

## ECC Commands (everything-claude-code)

> Installed via `./install.sh --profile full`. Requires `ECC_HOOK_PROFILE=standard`.

### Core Workflow

| Command | Description |
|---------|-------------|
| `/plan "task"` | Restate requirements, assess risks, create step-by-step implementation plan (waits for confirmation before touching code) |
| `/tdd` | Test-driven development workflow (write tests first, then implement) |
| `/code-review` | Review local uncommitted changes, or pass a PR number to review a GitHub PR |
| `/build-fix` | Fix build errors |
| `/e2e` | Generate and run E2E tests |
| `/verify` | Verification loop (confirm implementation matches requirements) |
| `/quality-gate` | Quality gate checks |
| `/refactor-clean` | Refactor and clean up code |
| `/santa-loop` | Adversarial dual-review convergence loop (two independent reviewers must both approve before shipping) |

### Language-specific Build / Review / Test

| Command | Description |
|---------|-------------|
| `/cpp-build` | Fix C++ build errors and CMake issues |
| `/cpp-review` | C++ code review (memory safety, modern C++, concurrency) |
| `/cpp-test` | C++ TDD workflow (GoogleTest) |
| `/go-build` | Fix Go build errors and vet warnings |
| `/go-review` | Go code review (idiomatic patterns, concurrency safety, error handling) |
| `/go-test` | Go TDD workflow (table-driven tests) |
| `/kotlin-build` | Fix Kotlin/Gradle build errors |
| `/kotlin-review` | Kotlin code review (null safety, coroutines) |
| `/kotlin-test` | Kotlin TDD workflow (Kotest) |
| `/rust-build` | Fix Rust borrow checker and dependency issues |
| `/rust-review` | Rust code review (ownership, lifetimes, unsafe usage) |
| `/rust-test` | Rust TDD workflow (cargo-llvm-cov) |
| `/python-review` | Python code review (PEP 8, type hints, security) |
| `/gradle-build` | Fix Android/KMP Gradle build errors |

### Planning & PR

| Command | Description |
|---------|-------------|
| `/prp-plan "feature"` | Detailed feature implementation plan with codebase analysis and pattern extraction |
| `/prp-implement` | Execute an implementation plan with validation loops |
| `/prp-pr` | Create a GitHub PR from the current branch (auto-push and analyze changes) |
| `/prp-prd "feature"` | Interactive product requirements document generator |
| `/prp-commit "description"` | Describe what to commit in plain English (auto-selects files) |

### Session Management

| Command | Description |
|---------|-------------|
| `/save-session` | Save current session state to `~/.claude/session-data/` |
| `/resume-session` | Load the most recent session and resume work with full context |
| `/sessions` | Manage session history, aliases, and metadata |
| `/aside "question"` | Ask a quick side question without losing the current task context |

### Learning / Instincts

| Command | Description |
|---------|-------------|
| `/learn` | Extract reusable patterns from the current session |
| `/learn-eval` | Self-evaluate quality before extracting patterns; decides global vs project scope |
| `/instinct-status` | Show learned instincts (project + global) with confidence scores |
| `/instinct-export` | Export instincts to a file |
| `/instinct-import` | Import instincts from a file or URL |
| `/promote` | Promote project-scoped instincts to global scope |
| `/evolve` | Analyze instincts and suggest or generate evolved structures |
| `/prune` | Delete pending instincts older than 30 days that were never promoted |
| `/projects` | List all projects and their instinct statistics |

### Skills Management

| Command | Description |
|---------|-------------|
| `/skill-create` | Analyze local git history to extract patterns and generate SKILL.md files |
| `/skill-health` | Show skill portfolio health dashboard with analytics |

### Multi-Agent Workflows

| Command | Description |
|---------|-------------|
| `/multi-plan` | Multi-agent task planning |
| `/multi-backend` | Multi-agent backend implementation |
| `/multi-frontend` | Multi-agent frontend implementation |
| `/multi-execute` | Multi-agent execution |
| `/multi-workflow` | Full multi-agent workflow |

### Utilities

| Command | Description |
|---------|-------------|
| `/docs` | Documentation lookup (context7 integration) |
| `/setup-pm` | Configure preferred package manager (npm/pnpm/yarn/bun) |
| `/rules-distill` | Distill and update rule files |
| `/prompt-optimize` | Optimize prompt quality |
| `/update-docs` | Update documentation |

---

## Keyboard Shortcuts

### General Control

| Shortcut | Description |
|----------|-------------|
| `Ctrl+C` | Cancel current input or interrupt generation |
| `Ctrl+D` | Exit Claude Code |
| `Ctrl+L` | Clear terminal screen (preserves history) |
| `Ctrl+O` | Toggle verbose output (show tool use details) |
| `Ctrl+R` | Reverse-search command history |
| `Ctrl+T` | Toggle task list display |
| `Ctrl+B` | Move running task to background |
| `Esc Esc` | Revert to previous checkpoint |

### Mode Switching

| Shortcut | Description |
|----------|-------------|
| `Shift+Tab` | Cycle through permission modes |
| `Option+P` (Mac) / `Alt+P` | Switch model |
| `Option+T` (Mac) / `Alt+T` | Toggle extended thinking mode |
| `Option+O` (Mac) / `Alt+O` | Toggle fast mode |

### Multi-line Input

| Method | Description |
|--------|-------------|
| `\` + `Enter` | New line (works in all terminals) |
| `Option+Enter` (Mac) | New line (macOS default) |
| `Shift+Enter` | New line (requires `/terminal-setup` first) |

### Text Editing

| Shortcut | Description |
|----------|-------------|
| `Ctrl+K` | Delete from cursor to end of line |
| `Ctrl+U` | Delete from cursor to start of line |
| `Ctrl+Y` | Paste last deleted text |
| `Alt+B` | Move cursor one word left |
| `Alt+F` | Move cursor one word right |

---

## Vim Mode (enable with `/vim`)

### Mode Switching

| Key | Description |
|-----|-------------|
| `Esc` | Enter NORMAL mode |
| `i` | Insert before cursor |
| `a` | Insert after cursor |
| `A` | Insert at end of line |
| `o` | Open new line below |

### NORMAL Mode — Navigation

| Key | Description |
|-----|-------------|
| `h/j/k/l` | Left / Down / Up / Right |
| `w` | Next word |
| `b` | Previous word |
| `0` / `$` | Start / end of line |
| `gg` / `G` | Start / end of input box |

### NORMAL Mode — Editing

| Key | Description |
|-----|-------------|
| `x` | Delete character |
| `dd` | Delete entire line |
| `cc` | Change entire line |
| `yy` | Yank (copy) entire line |
| `p` | Paste after cursor |
| `.` | Repeat last operation |

---

## Authentication

```bash
claude auth login          # Log in
claude auth logout         # Log out
claude auth status         # Show authentication status
claude update              # Update to the latest version
```

---

## Custom Keybindings

Edit `~/.claude/keybindings.json`:

```json
{
  "bindings": [
    {
      "context": "Chat",
      "bindings": {
        "ctrl+e": "chat:externalEditor",
        "ctrl+u": null
      }
    }
  ]
}
```

> Run `/keybindings-help` for detailed instructions.

---

## Notes

- `Ctrl+C` and `Ctrl+D` are reserved by the system and cannot be rebound.
- When using tmux, `Ctrl+B` must be pressed twice to pass through to Claude Code.
- To enable `Option` key shortcuts on macOS, set Option as the Meta key in your terminal:
  - **iTerm2**: Settings → Profiles → Keys → Left Option = "Esc+"
  - **Terminal.app**: Settings → Profiles → Keyboard → check "Use Option as Meta Key"

---

## Spec Kit: Initialization (Init Project)

Getting started with Spec Kit in a new or existing project:

1. **Install Specify CLI (Global)**
   ```bash
   uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
   ```
2. **Initialize in Project Directory**
   ```bash
   specify init . --here --ai claude
   ```
*(Note: If integrating into an existing project, this will merge with existing templates without deleting your source code)*

---

## Spec Kit: Constitution Template

After initialization, paste the following as your **first** message to Claude to establish a solid guardrail for AI development:

**Copy & Paste this to Claude:**
```text
/speckit.constitution 
1. Core Spirit: Focus on Minimum Viable Product (MVP). Code MUST be high-quality, testable, and absolutely NO overdesign.
2. Complete Implementation: Provide fully working and executable code. NEVER use placeholders like TODO or `pass`.
3. Respect Architecture: Strictly follow the project's existing directory structure, patterns, and conventions. Do not introduce new frameworks or extra packages wildly.
4. Robustness & Security: Use Type Hints consistently. NEVER hardcode any sensible data or API keys. Always catch exceptions properly and return reasonable HTTP Status codes when handling external APIs.
5. Test Synchronization: Any modification to business logic MUST be accompanied by updates or additions to the corresponding Pytest cases.
6. Naming & Comments: Variables MUST be named in clear English. Critical logic comments and API Docstrings MUST be kept concise and written in English.
```

---

## Spec Kit: Core 5-Step Workflow

As the product manager, use these commands step-by-step for new features or bug fixes:

| Step | Usage & Example |
| --- | --- |
| 1. **`/speckit-constitution`** | Establish general principles (use the template above). |
| 2. **`/speckit-specify`** | **Define Requirements**: Explain business logic without deep technical details. |
| 3. **`/speckit-plan`** | **Generate Tech Plan**: AI reviews the spec and lists files to modify and design choices. |
| 4. **`/speckit-tasks`** | **Create Task List**: AI divides the plan into actionable chunks (Task 1, 2, 3...). |
| 5. **`/speckit-implement`** | **Execute Implementation**: AI starts coding and verifying the changes. |

---

## Spec Kit: Enhancement Skills

Use these optional skills to reduce AI hallucination risks on complex refactors:

* **`/speckit-clarify`** (use after `specify`, before `plan`): AI asks you structured questions to clarify edge cases and ambiguities.
* **`/speckit-checklist`** (use after `plan`): AI generates a QA checklist based on the agreed architecture.
* **`/speckit-analyze`** (use after `tasks`, before `implement`): AI verifies if the generated tasks fully cover the initial specify requirements.
