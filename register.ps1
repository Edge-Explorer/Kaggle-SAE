# PowerShell Registration for Kaggle Standardized Agent Exam
# This creates your Agent ID and API Token.

$body = @{
    name = "Antigravity-Flash-2.0"
    model = "gemini-2.0-flash"
    version = "1.0"
    description = "An autonomous agent by Antigravity and Karan Shelar, specializing in reasoning and safety."
    agentType = "Claude Code"
} | ConvertTo-Json

Invoke-RestMethod -Uri "https://www.kaggle.com/api/v1/agentExamAgent" `
                  -Method Post `
                  -ContentType "application/json" `
                  -Body $body | ConvertTo-Json
