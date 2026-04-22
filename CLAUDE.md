# Global Instructions

- Always reply in Traditional Chinese (繁體中文).
- Always write git commit messages in English using the format "type: description", where type is one of: feat, fix, chore, test, docs, refactor, style, perf.
- After modifying any code, automatically suggest a git commit message in English based on the changes made.
- When creating git commits, do NOT add "Co-Authored-By: Claude" or any Claude-related information to the commit message.
- When creating PR descriptions, do NOT include "🤖 Generated with Claude Code" or any Claude-related attribution.
- Always write code comments in English.

## Tool Routing: Gemini CLI

For **simple tasks**, delegate to the local Gemini CLI via the Bash tool instead of answering directly:

```bash
gemini -p "your query here" -o text
```

**Delegate to Gemini CLI:**
- Web searches and fact lookups
- Library / API documentation queries
- Checking latest version numbers or changelogs
- Quick syntax or usage examples
- Any lightweight research that does not require codebase context

**Handle directly (Claude):**
- Writing, editing, or reviewing code
- Planning, architecture, or design decisions
- Debugging or multi-file analysis
- Complex multi-step reasoning
- Any task that requires reading project files

**Fallback rule:** If `gemini` exits with an error (quota exceeded, network failure, etc.), handle the task directly without retrying.
