# Load variables from .env manually in PowerShell
Get-Content ".env" | ForEach-Object {
    if ($_ -match '^\s*([^#\s][^=]*)\s*=\s*"?([^"]*)"?\s*$') {
        [System.Environment]::SetEnvironmentVariable($matches[1], $matches[2])
    }
}

$apiToken = $env:KAGGLE_API_TOKEN

if (-not $apiToken) {
    Write-Error "KAGGLE_API_TOKEN not found in .env!"
    return
}

$headers = @{
    "Authorization" = "Bearer $apiToken"
    "Content-Type"  = "application/json"
}

# The request to start the exam
Try {
    $response = Invoke-RestMethod -Uri "https://www.kaggle.com/api/v1/agentExamSubmission" `
                                  -Method Post `
                                  -Headers $headers `
                                  -Body "{}"

    # Save the full response as JSON in our folder
    $response | ConvertTo-Json -Depth 5 | Out-File -FilePath "questions.json" -Encoding utf8
    Write-Host "Success! Questions saved to questions.json." -ForegroundColor Green
} Catch {
    Write-Error "API Error: $_"
}