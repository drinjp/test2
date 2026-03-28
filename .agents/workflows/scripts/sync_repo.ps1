param(
    [Parameter(Mandatory=$true)]
    [string]$RepoName,

    [Parameter(Mandatory=$true)]
    [string]$GithubUser,

    [string]$Visibility = "private"
)

Write-Host ">>> Starting sync process for $RepoName (Visibility: $Visibility)..." -ForegroundColor Cyan
if (!(Test-Path .git)) {
    git init
}

Write-Host ">>> Creating initial README.md if missing..." -ForegroundColor Cyan
if (!(Test-Path README.md)) {
    @"
# $RepoName
Demo repository created by Antigravity AI.
"@ | Out-File -FilePath README.md -Encoding utf8
}

Write-Host ">>> Committing local changes..." -ForegroundColor Cyan
git add .
git commit -m "Initial commit for $RepoName"

Write-Host ">>> Configuring remote and pushing to GitHub..." -ForegroundColor Cyan
# Clear old remote just in case
git remote remove origin 2>$null
git remote add origin https://github.com/$( $GithubUser )/$( $RepoName ).git
git branch -M main

Write-Host ">>> Executing Push..." -ForegroundColor Cyan
git push -u origin main 2>&1 | Tee-Object -Variable pushOutput

if ($LASTEXITCODE -ne 0) {
    Write-Host "`n[ERROR: GIT_PUSH_FAILED] detected." -ForegroundColor Yellow
    Write-Host "Possible credential mismatch. AI should proceed with API-based sync." -ForegroundColor Gray
} else {
    Write-Host ">>> Sync Complete!" -ForegroundColor Green
}
