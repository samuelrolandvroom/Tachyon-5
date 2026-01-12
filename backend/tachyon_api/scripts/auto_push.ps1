
$branchName = "security-backup"
$intervalSeconds = 1800 # 30 minutes

Write-Host "Starting Auto-Push Service to branch: $branchName"
Write-Host "Interval: 30 minutes"

# Get current SSH config if set
$sshCmd = git config core.sshCommand

while ($true) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[$timestamp] Checking for changes..."
    
    # Check if there are any changes
    $status = git status --porcelain
    if ($status) {
        Write-Host "[$timestamp] Changes detected. Pushing to $branchName..."
        
        # Don't fail if branch exists
        git checkout -b $branchName 2>$null
        git add .
        git commit -m "Auto-backup: $timestamp"
        
        # Push using the specific SSH command from local config
        if ($sshCmd) {
            git -c "core.sshCommand=$sshCmd" push origin $branchName -f
        }
        else {
            git push origin $branchName -f
        }
        
        Write-Host "[$timestamp] Push complete."
        git checkout main 2>$null
    }
    else {
        Write-Host "[$timestamp] No changes to push."
    }
    
    Start-Sleep -Seconds $intervalSeconds
}
