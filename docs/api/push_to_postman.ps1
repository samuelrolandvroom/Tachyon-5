
# Postman API Sync Script
# This script pushes your local collection to Postman automatically.

# --- CONFIGURATION ---
# 1. Get your API Key from: https://web.postman.co/settings/me/api-keys
$apiKey = "YOUR_POSTMAN_API_KEY"

# 2. Get your Collection UID:
#    In Postman, click the (...) next to your collection -> Info -> Copy ID
$collectionUid = "YOUR_COLLECTION_UID"

$filePath = "tachyon_api.postman_collection.json"
# ---------------------

$CurrentScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$absolutePath = Join-Path $CurrentScriptRoot $filePath

if ($apiKey -eq "YOUR_POSTMAN_API_KEY" -or $collectionUid -eq "YOUR_COLLECTION_UID") {
    Write-Host "--- SETUP REQUIRED ---" -ForegroundColor Yellow
    Write-Host "Please open this script and enter your Postman API Key and Collection UID."
    Write-Host "You can find them at the links provided in the script comments."
    exit 1
}

Write-Host "Syncing $absolutePath to Postman..."

if (-Not (Test-Path $absolutePath)) {
    Write-Error "Collection file not found at $absolutePath"
    exit 1
}

$collectionJson = Get-Content -Path $absolutePath -Raw | ConvertFrom-Json

# Wrap the collection in a "collection" object for the Postman API
$body = @{ collection = $collectionJson } | ConvertTo-Json -Depth 10

$headers = @{
    "X-Api-Key"    = $apiKey
    "Content-Type" = "application/json"
}

try {
    $response = Invoke-RestMethod -Uri "https://api.getpostman.com/collections/$collectionUid" -Method Put -Header $headers -Body $body
    Write-Host "Success! Collection updated at $(Get-Date)" -ForegroundColor Green
}
catch {
    Write-Error "Failed to update collection: $_"
    if ($_.Exception.Response) {
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $respBody = $reader.ReadToEnd()
        Write-Host "Response Body: $respBody" -ForegroundColor Red
    }
}
