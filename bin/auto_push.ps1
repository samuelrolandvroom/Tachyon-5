
$branchName = "security-backup"
$intervalSeconds = 1800 # 30 minutes

Write-Host "Starting Auto-Push Service to branch: $branchName"
Write-Host "Interval: 30 minutes"

# Ensure SSH key is used if it was configured for origin
$sshCmd = git config core.sshCommand

while ($true) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[$timestamp] Checking for changes..."
    
    # Check if there are any changes (staged or unstaged)
    $status = git status --porcelain
    if ($status) {
        Write-Host "[$timestamp] Changes detected. Pushing to $branchName..."
        
        git checkout -b $branchName 2>$null
        git add .
        git commit -m "Auto-backup: $timestamp"
        
        # Use the specific SSH key if it's set in config
        if ($sshCmd) {
            Write-Host "Using configured SSH key..."
            git -c "core.sshCommand=$sshCmd" push origin $branchName -f
        }
        else {
            git push origin $branchName -f
        }
        
        Write-Host "[$timestamp] Push complete."
        # Go back to main if we were there
        git checkout main 2>$null
    }
    else {
        Write-Host "[$timestamp] No changes to push."
    }
    
    Start-Sleep -Seconds $intervalSeconds
}
