# Claude Code Terminal Cheatsheet

> 常用操作速查表。完整文件請見 [官方文件](https://docs.anthropic.com/en/docs/claude-code)

個人設定說明請見 [my-config.md](my-config.md)。

---

## 啟動方式

```bash
claude                        # 開啟互動模式
claude "問題"                  # 帶初始提示開啟
claude -p "問題"               # 非互動模式，印出結果後退出
cat file.txt | claude -p "問題" # 處理 pipe 輸入
claude -c                     # 繼續最近一次對話
claude -r "session-name"      # 恢復指定 session
```

---

## CLI 常用旗標

| 旗標 | 說明 |
|------|------|
| `-c, --continue` | 繼續當前目錄最近一次對話 |
| `-r, --resume` | 恢復指定 session（ID 或名稱）|
| `--model` | 指定模型（如 `sonnet`、`opus`）|
| `-p, --print` | 非互動模式，輸出後退出 |
| `--output-format` | 輸出格式：`text`、`json`、`stream-json` |
| `--max-turns N` | 限制最大 agentic 回合數（配合 `-p` 使用）|
| `--permission-mode` | 啟動時設定權限模式（`plan`、`auto`、`default`）|
| `--add-dir <path>` | 增加額外工作目錄 |
| `--verbose` | 詳細日誌輸出 |
| `--version` | 顯示版本號 |

---

## 輸入前綴

| 前綴 | 說明 |
|------|------|
| `/` | 執行 slash 指令或 skill |
| `!` | 直接執行 bash 指令（不經 Claude 解讀）|
| `@` | 引用檔案路徑（自動補全）|

---

## 內建 Slash 指令

| 指令 | 說明 |
|------|------|
| `/help` | 顯示說明 |
| `/clear` | 開始新 session |
| `/resume` | 恢復先前 session |
| `/memory` | 檢視/編輯 CLAUDE.md 與記憶 |
| `/settings` | 開啟設定選單 |
| `/hooks` | 管理 hooks |
| `/cost` | 查看 API 花費 |
| `/doctor` | 診斷問題 |
| `/vim` | 啟用 vim 編輯模式 |
| `/terminal-setup` | 設定終端機（如啟用 Shift+Enter 換行）|
| `/commit` | 建立 git commit |
| `/compact` | 壓縮對話歷史以節省 context |

---

## ECC 指令（everything-claude-code）

> 透過 `./install.sh --profile full` 安裝。需設定 `ECC_HOOK_PROFILE=standard`。

### 核心工作流程

| 指令 | 說明 |
|------|------|
| `/plan "任務"` | 重申需求、評估風險、產生逐步實作計畫（等待確認後才動手）|
| `/tdd` | TDD 工作流程（先寫測試再實作）|
| `/code-review` | 審查本地未 commit 的變更，或傳入 PR 號碼審查 GitHub PR |
| `/build-fix` | 修復 build 錯誤 |
| `/e2e` | 產生並執行 E2E 測試 |
| `/verify` | 驗證迴圈（確認實作符合需求）|
| `/quality-gate` | 品質門檻檢查 |
| `/refactor-clean` | 重構清理 |
| `/santa-loop` | 雙重對立審查收斂迴圈（兩個 reviewer 都核准才能出貨）|

### 語言別 Build / Review / Test

| 指令 | 說明 |
|------|------|
| `/cpp-build` | 修復 C++ build 錯誤與 CMake 問題 |
| `/cpp-review` | C++ 程式碼審查（記憶體安全、現代 C++、並發）|
| `/cpp-test` | C++ TDD 工作流程（GoogleTest）|
| `/go-build` | 修復 Go build 錯誤與 vet 警告 |
| `/go-review` | Go 程式碼審查（慣用模式、並發安全、錯誤處理）|
| `/go-test` | Go TDD 工作流程（table-driven tests）|
| `/kotlin-build` | 修復 Kotlin/Gradle build 錯誤 |
| `/kotlin-review` | Kotlin 程式碼審查（null 安全、coroutine）|
| `/kotlin-test` | Kotlin TDD 工作流程（Kotest）|
| `/rust-build` | 修復 Rust borrow checker 與依賴問題 |
| `/rust-review` | Rust 程式碼審查（ownership、lifetimes、unsafe）|
| `/rust-test` | Rust TDD 工作流程（cargo-llvm-cov）|
| `/python-review` | Python 程式碼審查（PEP 8、type hints、安全性）|
| `/gradle-build` | 修復 Android/KMP Gradle build 錯誤 |

### 規劃與 PR

| 指令 | 說明 |
|------|------|
| `/prp-plan "功能"` | 詳細功能實作計畫（含 codebase 分析與模式萃取）|
| `/prp-implement` | 執行實作計畫（帶驗證迴圈）|
| `/prp-pr` | 從當前分支建立 GitHub PR（自動 push 與分析）|
| `/prp-prd "功能"` | 互動式產品需求文件產生器 |
| `/prp-commit "描述"` | 用自然語言描述要 commit 什麼（自動選擇檔案）|

### Session 管理

| 指令 | 說明 |
|------|------|
| `/save-session` | 儲存目前 session 狀態到 `~/.claude/session-data/` |
| `/resume-session` | 載入最近一次 session 並恢復工作 |
| `/sessions` | 管理 session 歷史、別名與元資料 |
| `/aside "問題"` | 快速問旁支問題，不中斷目前任務上下文 |

### Learning / Instincts

| 指令 | 說明 |
|------|------|
| `/learn` | 從本次 session 萃取可重用模式 |
| `/learn-eval` | 萃取模式前先自我評估品質，決定存到全域或專案 |
| `/instinct-status` | 顯示已學習的 instincts（專案 + 全域）與信心分數 |
| `/instinct-export` | 匯出 instincts 到檔案 |
| `/instinct-import` | 從檔案或 URL 匯入 instincts |
| `/promote` | 將專案 instincts 提升為全域 |
| `/evolve` | 分析 instincts 並建議/產生進化結構 |
| `/prune` | 刪除 30 天以上未提升的待定 instincts |
| `/projects` | 列出所有專案與其 instinct 統計 |

### Skills 管理

| 指令 | 說明 |
|------|------|
| `/skill-create` | 從本地 git 歷史萃取模式並產生 SKILL.md |
| `/skill-health` | 顯示 skill 組合健康儀表板 |

### 多 Agent 工作流程

| 指令 | 說明 |
|------|------|
| `/multi-plan` | 多 agent 任務規劃 |
| `/multi-backend` | 多 agent 後端實作 |
| `/multi-frontend` | 多 agent 前端實作 |
| `/multi-execute` | 多 agent 執行 |
| `/multi-workflow` | 完整多 agent 工作流程 |

### 工具類

| 指令 | 說明 |
|------|------|
| `/docs` | 查詢文件（context7 整合）|
| `/setup-pm` | 設定偏好的 package manager（npm/pnpm/yarn/bun）|
| `/rules-distill` | 精煉並更新規則檔案 |
| `/prompt-optimize` | 優化提示詞品質 |
| `/update-docs` | 更新文件 |

---

## 鍵盤快捷鍵

### 通用控制

| 快捷鍵 | 說明 |
|--------|------|
| `Ctrl+C` | 取消當前輸入或中斷生成 |
| `Ctrl+D` | 退出 Claude Code |
| `Ctrl+L` | 清除終端機畫面（保留歷史）|
| `Ctrl+O` | 切換詳細輸出（顯示工具使用詳情）|
| `Ctrl+R` | 反向搜尋指令歷史 |
| `Ctrl+T` | 切換 task list 顯示 |
| `Ctrl+B` | 將執行中的任務移到背景 |
| `Esc Esc` | 回退到上一個檢查點 |

### 模式切換

| 快捷鍵 | 說明 |
|--------|------|
| `Shift+Tab` | 循環切換權限模式 |
| `Option+P` (Mac) / `Alt+P` | 切換模型 |
| `Option+T` (Mac) / `Alt+T` | 切換 extended thinking 模式 |
| `Option+O` (Mac) / `Alt+O` | 切換 fast 模式 |

### 多行輸入

| 方法 | 說明 |
|------|------|
| `\` + `Enter` | 換行（所有終端機皆支援）|
| `Option+Enter` (Mac) | 換行（macOS 預設）|
| `Shift+Enter` | 換行（需先執行 `/terminal-setup`）|

### 文字編輯

| 快捷鍵 | 說明 |
|--------|------|
| `Ctrl+K` | 刪除游標到行尾 |
| `Ctrl+U` | 刪除游標到行首 |
| `Ctrl+Y` | 貼上剛刪除的文字 |
| `Alt+B` | 游標向左移一個字 |
| `Alt+F` | 游標向右移一個字 |

---

## Vim 模式（`/vim` 啟用後）

### 模式切換

| 按鍵 | 說明 |
|------|------|
| `Esc` | 進入 NORMAL 模式 |
| `i` | 在游標前插入 |
| `a` | 在游標後插入 |
| `A` | 在行尾插入 |
| `o` | 在下方新增一行 |

### NORMAL 模式 - 移動

| 按鍵 | 說明 |
|------|------|
| `h/j/k/l` | 左/下/上/右 |
| `w` | 下一個字 |
| `b` | 上一個字 |
| `0` / `$` | 行首 / 行尾 |
| `gg` / `G` | 輸入框開頭 / 結尾 |

### NORMAL 模式 - 編輯

| 按鍵 | 說明 |
|------|------|
| `x` | 刪除字元 |
| `dd` | 刪除整行 |
| `cc` | 修改整行 |
| `yy` | 複製整行 |
| `p` | 貼上（游標後）|
| `.` | 重複上一個操作 |

---

## 認證

```bash
claude auth login          # 登入
claude auth logout         # 登出
claude auth status         # 顯示認證狀態
claude update              # 更新到最新版本
```

---

## 自訂快捷鍵

編輯 `~/.claude/keybindings.json`：

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

> 執行 `/keybindings-help` 查看詳細說明

---

## 注意事項

- `Ctrl+C`、`Ctrl+D` 為系統保留，無法重新綁定
- 使用 tmux 時，`Ctrl+B` 需按兩次才能傳入 Claude Code
- macOS 要讓 `Option` 鍵快捷鍵生效，需在終端機設定中將 Option 設為 Meta 鍵：
  - **iTerm2**: Settings → Profiles → Keys → Left Option = "Esc+"
  - **Terminal.app**: Settings → Profiles → Keyboard → 勾選 "Use Option as Meta Key"
