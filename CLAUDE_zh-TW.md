# 全域指令 (Global Instructions)

- 始終以繁體中文 (Traditional Chinese) 回覆。
- 始終以英文撰寫 git commit 訊息，使用格式 "type: description"，其中 type 為以下之一：feat, fix, chore, test, docs, refactor, style, perf。
- 修改任何程式碼後，自動根據所做的更改提供建議的英文 git commit 訊息。
- 建立 git commit 時，不要在 commit 訊息中加入 "Co-Authored-By: Claude" 或任何與 Claude 相關的資訊。
- 建立 PR 描述時，不要包含 "🤖 Generated with Claude Code" 或任何與 Claude 相關的署名。
- 始終以英文撰寫程式碼註解。

## 工具路由：Gemini CLI

對於**簡單任務**，請透過 Bash 工具委派給本機的 Gemini CLI，而不是直接回答：

```bash
gemini -p "你的查詢放在這裡" -o text
```

**委派給 Gemini CLI：**
- 網路搜尋與事實查詢
- 函式庫 / API 文件查詢
- 檢查最新版本號或更新日誌 (changelogs)
- 快速語法或用法範例
- 任何不需要程式碼庫上下文的輕量級研究

**直接處理 (Claude)：**
- 撰寫、編輯或審查程式碼
- 規劃、架構或設計決策
- 除錯或多檔案分析
- 複雜的多步驟推理
- 任何需要讀取專案檔案的任務

**備用規則：** 如果 `gemini` 退出並顯示錯誤（配額超出、網路連線失敗等），則直接處理任務而不重試。
