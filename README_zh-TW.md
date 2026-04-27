# Claude Code 終端機備忘錄 (Claude Code Terminal Cheatsheet)

> 常用操作的快速參考。完整文件請參閱[官方文件](https://docs.anthropic.com/en/docs/claude-code)。

個人配置筆記：[my-config.md](my-config.md)。

---

## 啟動 Claude Code

```bash
claude                        # 開啟互動模式
claude "prompt"               # 帶有初始提示開啟
claude -p "prompt"            # 非互動模式，印出結果後退出
cat file.txt | claude -p "prompt"  # 處理管道輸入
claude -c                     # 繼續最近一次的對話
claude -r "session-name"      # 恢復特定會話
```

---

## CLI 標誌 (Flags)

| 標誌 | 描述 |
|------|-------------|
| `-c, --continue` | 在當前目錄中繼續最近一次的對話 |
| `-r, --resume` | 恢復特定的會話（依據 ID 或名稱） |
| `--model` | 指定模型（例如 `sonnet`, `opus`） |
| `-p, --print` | 非互動模式，輸出後退出 |
| `--output-format` | 輸出格式：`text`, `json`, `stream-json` |
| `--max-turns N` | 限制最大代理輪數（與 `-p` 搭配使用） |
| `--permission-mode` | 設定啟動時的權限模式（`plan`, `auto`, `default`） |
| `--add-dir <path>` | 新增額外的工作目錄 |
| `--verbose` | 輸出詳細日誌 |
| `--version` | 顯示版本號 |

---

## 輸入前綴 (Input Prefixes)

| 前綴 | 描述 |
|--------|-------------|
| `/` | 執行斜線指令或技能 (skill) |
| `!` | 直接執行 bash 指令（繞過 Claude） |
| `@` | 參照檔案路徑（帶有自動完成） |

---

## 內建斜線指令 (Built-in Slash Commands)

| 指令 | 描述 |
|---------|-------------|
| `/help` | 顯示幫助 |
| `/clear` | 開始新的會話 |
| `/resume` | 恢復先前的會話 |
| `/memory` | 檢視/編輯 CLAUDE.md 和記憶 |
| `/settings` | 開啟設定選單 |
| `/hooks` | 管理掛鉤 (hooks) |
| `/cost` | 檢視 API 使用成本 |
| `/doctor` | 診斷問題 |
| `/vim` | 啟用 vim 編輯模式 |
| `/terminal-setup` | 配置終端機（例如啟用 Shift+Enter 換行） |
| `/commit` | 建立 git commit |
| `/compact` | 壓縮對話歷史以節省上下文 |

---

## ECC 指令 (everything-claude-code)

> 透過 `./install.sh --profile full` 安裝。需要 `ECC_HOOK_PROFILE=standard`。

### 核心工作流 (Core Workflow)

| 指令 | 描述 |
|---------|-------------|
| `/plan "task"` | 重述需求、評估風險、建立逐步實作計畫（在修改程式碼前會等待確認） |
| `/tdd` | 測試驅動開發工作流（先寫測試，再實作） |
| `/code-review` | 審查本地未提交的更改，或傳入 PR 號碼以審查 GitHub PR |
| `/build-fix` | 修復建置錯誤 |
| `/e2e` | 產生並執行端到端 (E2E) 測試 |
| `/verify` | 驗證循環（確認實作符合需求） |
| `/quality-gate` | 品質閘門檢查 |
| `/refactor-clean` | 重構並清理程式碼 |
| `/santa-loop` | 對抗性雙重審查收斂循環（必須兩位獨立的審查者皆同意才能發布） |

### 特定語言建置 / 審查 / 測試 (Language-specific Build / Review / Test)

| 指令 | 描述 |
|---------|-------------|
| `/cpp-build` | 修復 C++ 建置錯誤與 CMake 問題 |
| `/cpp-review` | C++ 程式碼審查（記憶體安全、現代 C++、並行） |
| `/cpp-test` | C++ TDD 工作流 (GoogleTest) |
| `/go-build` | 修復 Go 建置錯誤與 vet 警告 |
| `/go-review` | Go 程式碼審查（慣用模式、並行安全、錯誤處理） |
| `/go-test` | Go TDD 工作流 (表格驅動測試) |
| `/kotlin-build` | 修復 Kotlin/Gradle 建置錯誤 |
| `/kotlin-review` | Kotlin 程式碼審查（空值安全、協程） |
| `/kotlin-test` | Kotlin TDD 工作流 (Kotest) |
| `/rust-build` | 修復 Rust 借用檢查器與依賴問題 |
| `/rust-review` | Rust 程式碼審查（所有權、生命週期、不安全使用） |
| `/rust-test` | Rust TDD 工作流 (cargo-llvm-cov) |
| `/python-review` | Python 程式碼審查（PEP 8、型別提示、安全） |
| `/gradle-build` | 修復 Android/KMP Gradle 建置錯誤 |

### 規劃與 PR (Planning & PR)

| 指令 | 描述 |
|---------|-------------|
| `/prp-plan "feature"` | 詳細功能實作計畫，包含程式碼庫分析與模式提取 |
| `/prp-implement` | 執行具有驗證循環的實作計畫 |
| `/prp-pr` | 從當前分支建立 GitHub PR（自動推送並分析更改） |
| `/prp-prd "feature"` | 互動式產品需求文件生成器 |
| `/prp-commit "description"` | 用白話文描述要提交的內容（自動選取檔案） |

### 會話管理 (Session Management)

| 指令 | 描述 |
|---------|-------------|
| `/save-session` | 將當前會話狀態儲存至 `~/.claude/session-data/` |
| `/resume-session` | 載入最近一次的會話並保留完整上下文繼續工作 |
| `/sessions` | 管理會話歷史、別名與元資料 |
| `/aside "question"` | 在不遺失當前任務上下文的情況下詢問快速的旁支問題 |

### 學習 / 直覺 (Learning / Instincts)

| 指令 | 描述 |
|---------|-------------|
| `/learn` | 從當前會話中提取可重用的模式 |
| `/learn-eval` | 在提取模式前自我評估品質；決定全域還是專案範圍 |
| `/instinct-status` | 顯示已學習的直覺（專案 + 全域）與信心分數 |
| `/instinct-export` | 匯出直覺至檔案 |
| `/instinct-import` | 從檔案或 URL 匯入直覺 |
| `/promote` | 將專案範圍的直覺提升為全域範圍 |
| `/evolve` | 分析直覺並提出建議或產生演化後的結構 |
| `/prune` | 刪除超過 30 天未被提升的待處理直覺 |
| `/projects` | 列出所有專案及其直覺統計數據 |

### 技能管理 (Skills Management)

| 指令 | 描述 |
|---------|-------------|
| `/skill-create` | 分析本地 git 歷史記錄以提取模式並產生 SKILL.md 檔案 |
| `/skill-health` | 顯示帶有分析數據的技能組合健康儀表板 |

### 多代理工作流 (Multi-Agent Workflows)

| 指令 | 描述 |
|---------|-------------|
| `/multi-plan` | 多代理任務規劃 |
| `/multi-backend` | 多代理後端實作 |
| `/multi-frontend` | 多代理前端實作 |
| `/multi-execute` | 多代理執行 |
| `/multi-workflow` | 完整多代理工作流 |

### 工具程式 (Utilities)

| 指令 | 描述 |
|---------|-------------|
| `/docs` | 文件查找（context7 整合） |
| `/setup-pm` | 設定偏好的套件管理器（npm/pnpm/yarn/bun） |
| `/rules-distill` | 提煉並更新規則檔案 |
| `/prompt-optimize` | 最佳化提示品質 |
| `/update-docs` | 更新文件 |

---

## 鍵盤快捷鍵 (Keyboard Shortcuts)

### 一般控制 (General Control)

| 快捷鍵 | 描述 |
|----------|-------------|
| `Ctrl+C` | 取消當前輸入或中斷生成 |
| `Ctrl+D` | 退出 Claude Code |
| `Ctrl+L` | 清除終端機畫面（保留歷史記錄） |
| `Ctrl+O` | 切換詳細輸出（顯示工具使用細節） |
| `Ctrl+R` | 反向搜尋指令歷史 |
| `Ctrl+T` | 切換顯示任務清單 |
| `Ctrl+B` | 將運行中的任務移至背景 |
| `Esc Esc` | 恢復到上一個檢查點 |

### 模式切換 (Mode Switching)

| 快捷鍵 | 描述 |
|----------|-------------|
| `Shift+Tab` | 循環切換權限模式 |
| `Option+P` (Mac) / `Alt+P` | 切換模型 |
| `Option+T` (Mac) / `Alt+T` | 切換深度思考模式 (extended thinking mode) |
| `Option+O` (Mac) / `Alt+O` | 切換快速模式 (fast mode) |

### 多行輸入 (Multi-line Input)

| 方法 | 描述 |
|--------|-------------|
| `\` + `Enter` | 換行（適用於所有終端機） |
| `Option+Enter` (Mac) | 換行（macOS 預設） |
| `Shift+Enter` | 換行（需先執行 `/terminal-setup`） |

### 文字編輯 (Text Editing)

| 快捷鍵 | 描述 |
|----------|-------------|
| `Ctrl+K` | 刪除從游標到行尾的文字 |
| `Ctrl+U` | 刪除從游標到行首的文字 |
| `Ctrl+Y` | 貼上最後刪除的文字 |
| `Alt+B` | 游標向左移動一個單字 |
| `Alt+F` | 游標向右移動一個單字 |

---

## Vim 模式 (使用 `/vim` 啟用)

### 模式切換

| 按鍵 | 描述 |
|-----|-------------|
| `Esc` | 進入一般 (NORMAL) 模式 |
| `i` | 在游標前插入 |
| `a` | 在游標後插入 |
| `A` | 在行尾插入 |
| `o` | 在下方開啟新行 |

### 一般模式 — 導航

| 按鍵 | 描述 |
|-----|-------------|
| `h/j/k/l` | 左 / 下 / 上 / 右 |
| `w` | 下一個單字 |
| `b` | 上一個單字 |
| `0` / `$` | 行首 / 行尾 |
| `gg` / `G` | 輸入框開頭 / 結尾 |

### 一般模式 — 編輯

| 按鍵 | 描述 |
|-----|-------------|
| `x` | 刪除字元 |
| `dd` | 刪除整行 |
| `cc` | 更改整行 |
| `yy` | 複製 (Yank) 整行 |
| `p` | 在游標後貼上 |
| `.` | 重複上一個操作 |

---

## 身分驗證 (Authentication)

```bash
claude auth login          # 登入
claude auth logout         # 登出
claude auth status         # 顯示身分驗證狀態
claude update              # 更新至最新版本
```

---

## 自訂鍵盤綁定 (Custom Keybindings)

編輯 `~/.claude/keybindings.json`:

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

> 執行 `/keybindings-help` 獲取詳細說明。

---

## 備註 (Notes)

- `Ctrl+C` 與 `Ctrl+D` 為系統保留，無法重新綁定。
- 當使用 tmux 時，必須按兩次 `Ctrl+B` 才能傳遞給 Claude Code。
- 若要在 macOS 上啟用 `Option` 鍵快捷鍵，請在終端機中將 Option 設為 Meta 鍵：
  - **iTerm2**: Settings → Profiles → Keys → Left Option = "Esc+"
  - **Terminal.app**: Settings → Profiles → Keyboard → 勾選 "Use Option as Meta Key"

---

## Spec Kit: 初始化 (Init Project)

在全新或現有專案中開始使用 Spec Kit：

1. **安裝 Specify CLI (全域)**
   ```bash
   uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
   ```
2. **在專案目錄中初始化**
   ```bash
   specify init . --here --ai claude
   ```
*(備註：如果是整合到現有專案中，這將會與現有模板合併，而不會刪除您的原始碼)*

---

## Spec Kit: 憲章模板 (Constitution Template)

初始化後，將以下內容作為您傳遞給 Claude 的**第一則**訊息，以為 AI 開發建立堅實的護欄：

**複製並貼上給 Claude:**
```text
/speckit.constitution 
1. 核心精神 (Core Spirit): 專注於最小可行產品 (MVP)。程式碼必須高品質、可測試，且絕對不要過度設計。
2. 完整實作 (Complete Implementation): 提供完整可運作且可執行的程式碼。絕對不要使用 TODO 或 `pass` 等佔位符。
3. 尊重架構 (Respect Architecture): 嚴格遵循專案現有的目錄結構、模式與慣例。不要隨意引入新的框架或額外套件。
4. 穩健性與安全 (Robustness & Security): 一致地使用型別提示。絕對不要硬編碼任何敏感資料或 API 金鑰。處理外部 API 時，務必妥善捕捉例外並回傳合理的 HTTP 狀態碼。
5. 測試同步 (Test Synchronization): 任何對業務邏輯的修改都必須伴隨相應的 Pytest 案例更新或新增。
6. 命名與註解 (Naming & Comments): 變數必須以清晰的英文命名。關鍵邏輯註解與 API Docstrings 必須保持簡潔並以英文撰寫。
```

---

## Spec Kit: 核心 5 步驟工作流 (Core 5-Step Workflow)

身為產品經理，針對新功能或錯誤修復逐步使用以下指令：

| 步驟 | 用法與範例 |
| --- | --- |
| 1. **`/speckit-constitution`** | 建立一般原則（使用上述模板）。 |
| 2. **`/speckit-specify`** | **定義需求**：解釋業務邏輯，不涉及過深層的技術細節。 |
| 3. **`/speckit-plan`** | **產生技術計畫**：AI 審查規範並列出要修改的檔案及設計選擇。 |
| 4. **`/speckit-tasks`** | **建立任務清單**：AI 將計畫劃分為可執行的部分（任務 1、2、3...）。 |
| 5. **`/speckit-implement`** | **執行實作**：AI 開始編寫程式碼並驗證更改。 |

---

## Spec Kit: 增強技能 (Enhancement Skills)

使用這些選用技能來降低在複雜重構中 AI 產生幻覺的風險：

* **`/speckit-clarify`** (在 `specify` 之後、`plan` 之前使用): AI 會詢問您結構化的問題，以釐清邊緣情況與模糊地帶。
* **`/speckit-checklist`** (在 `plan` 之後使用): AI 會根據約定的架構產生 QA 檢查清單。
* **`/speckit-analyze`** (在 `tasks` 之後、`implement` 之前使用): AI 會驗證產生的任務是否完全涵蓋最初的 specify 需求。
