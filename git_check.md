# GitHub & Git 同步確認清單 (Checklist)

這份清單總結了在建立與同步 GitHub 儲存庫時可能遇到的問題與解決方案。

### 1. GitHub Token 權限檢核

當執行 `create_repository` 或 `push_files` 時，如果出現 **403 Forbidden**，請檢查：

- [ ] **Classic Token**: 是否勾選了 `repo` 權限。
- [ ] **Fine-grained Token**:
  - [ ] **Administration**: `Read and write` (建立儲存庫必備)。
  - [ ] **Contents**: `Read and write` (推送檔案至 main 分支必備)。
  - [ ] **Metadata**: `Read-only` (基本系統權限)。
  - [ ] **Workflows**: `Read and write` (若需要開啟 GitHub Pages)。

### 2. 本機 Git 環境檢查

- [ ] **初始化**：確認目錄已執行 `git init`。
- [ ] **遠端分支**：確認 `git remote -v` 是否指向正確的 URL。
- [ ] **分支名稱**：建議將預設分支強制命名為 `main` (執行 `git branch -M main`)，以對應 GitHub 預設。

### 3. 命令執行注意事項 (PowerShell)

- [ ] **多重命令分隔符**：在 Windows PowerShell 中，請避免使用 `&&`。請改用 `;` 來連接多個命令（例如：`git add .; git commit -m "msg"`）。

### 4. 同步與推送策略

- [ ] **認證問題解決**：如果本機 `git push` 因認證失敗（彈出登入視窗或 403），可優先嘗試使用 **`mcp_github-mcp-server_push_files`** 工具，此工具透過 GitHub API 直接推送，不依賴本機端的 Git 憑證。
- [ ] **repo 命名確認**：建立 repo 之前，先確認 GitHub 上是否已有同名 repo，避免衝突。

### 5. 檔案管理

- [ ] **初始化內容**：若為測試用途，建議先以簡單的 `README.md` 進行起始同步，確認流程通暢後再加入複雜檔案（如 `index.html`）。

---

## 🚀 Git MCP 建立儲存庫標準流程 (Flow)

### Step 1: 資訊確認與溝通
- **必要資訊**：在調用工具前，必須確認 **儲存庫名稱 (Repo Name)** 與 **隱私屬性 (Public/Private)**。
- [ ] **檢查點**：若使用者未提供上述資訊，應主動詢問，避免工具調用失敗。

### Step 2: 環境適應與腳本化 (Windows)
- **環境限制**：Windows PowerShell 不支援 `&&`。
- **節省 Token 策略**：避免分開調用多次 `run_command`（如 `git add` -> `git commit` -> `git push`），應將所有本機 Git 操作整合進一個 `.ps1` 腳本執行。

#### 推薦操作流程：
1. **GitHub 端**：調用 `mcp_github-mcp-server_create_repository` 建立專案。
2. **本機端**：產生或執行 [sync_repo.ps1](file:///c:/Users/drinj/Desktop/Antigravity/Git%20Page%20Test/sync_repo.ps1)。
3. **驗證**：檢查執行結果並回報。
