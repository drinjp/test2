---
description: 建立 GitHub 儲存庫並同步本機程式碼 (Git MCP 流程)
---

1. 資訊確認：
   - 確認 **儲存庫名稱 (Repo Name)**。
   - 確認 **隱私屬性 (Public/Private)**。
   - 如果使用者未提供，請先詢問。

2. 雲端倉庫建立：
   - 使用 `mcp_github-mcp-server_create_repository` 建立專案。
   - 確保傳入正確的 `name` 與 `private` 參數。

3. 本機同步準備：
   - 確保本機目錄已執行 `git init`。
   - 確保目錄下存在 `README.md` 或其他初始檔案。

// turbo
4. 嘗試本機推送：
   - 執行 PowerShell 指令：`powershell -ExecutionPolicy Bypass -File .agents/workflows/scripts/sync_repo.ps1 -RepoName "<REPO_NAME>" -GithubUser "<GITHUB_USER>" -Visibility "<VISIBILITY>"`
   - 檢查執行輸出，確認是否包含 `[ERROR: GIT_PUSH_FAILED]`。

5. API 備援同步 (如 Step 4 失敗)：
   - 若偵測到 `[ERROR: GIT_PUSH_FAILED]`，AI 應自動執行以下補救措施：
     a. 列出目前目錄中所有需要同步的檔案。
     b. 使用 `view_file` 讀取各檔案內容。
     c. 調用 `mcp_github-mcp-server_push_files` 工具，將所有檔案透過 GitHub API 直接同步至目標倉庫的 `main` 分支。
   - 完成後向使用者回報「已透過 API 完成同步」。
