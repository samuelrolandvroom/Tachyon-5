
$baseUrl = "http://localhost:8183"

Write-Host "--- 1. Social Login (New User) ---"
$loginBody = @{
    provider = "google"
    token = "mock_google_bob456"
} | ConvertTo-Json
$loginResponse = Invoke-RestMethod -Uri "$baseUrl/auth/social/login" -Method Post -ContentType "application/json" -Body $loginBody
$loginResponse | ConvertTo-Json

if ($loginResponse.status -eq "incomplete") {
    Write-Host "`n--- 2. Complete Profile ---"
    $completeBody = @{
        socialData = $loginResponse.socialData
        username = "bob_builder"
        firstName = "Bob"
        lastName = "Builder"
        phoneNumber = "5550202"
    } | ConvertTo-Json
    $completeResponse = Invoke-RestMethod -Uri "$baseUrl/auth/complete_profile" -Method Post -ContentType "application/json" -Body $completeBody
    $completeResponse | ConvertTo-Json

    Write-Host "`n--- 3. Social Login (Returning User) ---"
    $loginResponse2 = Invoke-RestMethod -Uri "$baseUrl/auth/social/login" -Method Post -ContentType "application/json" -Body $loginBody
    $loginResponse2 | ConvertTo-Json
}
