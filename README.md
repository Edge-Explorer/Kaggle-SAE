# Kaggle Standardized Agent Exam — Agent Harness

A PowerShell-based agent harness built to autonomously register, take, and submit answers for the Kaggle Standardized Agent Exam (SAE). This repository documents the complete workflow — from registration to a verified passing result — and serves as a reproducible template for future exam attempts.

---

## What is the Kaggle Standardized Agent Exam?

The Kaggle Standardized Agent Exam (SAE) is an experimental benchmarking framework launched by Kaggle that evaluates AI agents across two core dimensions:

- **Reasoning:** Multi-step problem solving, mathematical reasoning, cipher decoding, pattern recognition, and code-level data analysis.
- **Adversarial Safety:** How responsibly an agent handles manipulative prompts such as prompt injection, phishing requests, social engineering, and attempts to leak sensitive data.

The exam consists of 16 questions and has a 30-minute time limit per submission. No Kaggle account is required to participate — agents register and interact entirely over HTTP using the Kaggle REST API. A public leaderboard is available at [www.kaggle.com/experimental/sae](https://www.kaggle.com/experimental/sae).

---

## Exam Result

- **Agent Name:** Antigravity-Flash-2.0
- **Model Used:** Gemini 2.0 Flash
- **Score:** 12 out of 16 (75%)
- **Status:** Passed
- **Certificate ID:** 969adac7-99d4-b70f-26bb-f977a21f93c9
- **Public Profile and Verification:** [https://www.kaggle.com/experimental/sae/7c8caf8f-4880-fb4d-68c4-2aa89d5b5580](https://www.kaggle.com/experimental/sae/7c8caf8f-4880-fb4d-68c4-2aa89d5b5580)

---

## Repository Structure

```
kaggle-sae-practice/
 |-- register.ps1       # Registers a new agent identity with the Kaggle API
 |-- start_exam.ps1     # Starts an exam session and saves questions locally
 |-- submit.ps1         # Submits answers and retrieves the final score
 |-- .gitignore         # Ensures secrets and question data are never committed
 |-- README.md          # This file
```

**Note:** The `.env` file (containing API keys) and `questions.json` (containing exam questions) are excluded from this repository via `.gitignore` for security and exam integrity reasons.

---

## How It Was Built — Step by Step

### Step 1: Environment Setup

Since this project runs on Windows, standard Bash scripts were not viable. All scripts were written in **PowerShell**, which is natively available on Windows and supports HTTP requests through the `Invoke-RestMethod` cmdlet.

A `.env` file was created locally to store sensitive credentials:

```
GEMINI_API_KEY=your_gemini_api_key_here
KAGGLE_API_TOKEN=your_kaggle_agent_token_here
```

This file is listed in `.gitignore` and was never committed to the repository.

---

### Step 2: Agent Registration (`register.ps1`)

Before starting the exam, an agent identity had to be created by sending a POST request to the Kaggle registration endpoint. The request payload included the agent's name, the underlying model identifier, a version string, a short description, and the agent framework type.

The API responded with an `agentId` and an `apiToken`. These credentials were saved locally to `~/.kaggle-agent-id` and `~/.kaggle-agent-api-key` respectively.

The `apiToken` is only returned once at registration time, so it was saved immediately.

---

### Step 3: Starting the Exam (`start_exam.ps1`)

With credentials in place, the exam was started by sending a POST request to the exam submission endpoint with the `Authorization: Bearer` header set to the saved API token.

The API returned a `submissionId`, a start timestamp, and the full list of 16 questions. The response was saved locally to `questions.json` for analysis. This file is excluded from the repository.

**Important:** Running this script starts the 30-minute countdown. It should only be run when ready to answer all questions.

---

### Step 4: Answering the Questions (`submit.ps1`)

Each question was analyzed and answered based on its type:

- **Reasoning questions** — Solved by applying mathematical logic, cipher analysis, pattern recognition, and programmatic counting. For example, one question required computing the trace of the adjugate matrix of a 3x3 matrix given its eigenvalues. Another required counting all circular primes below one million (answer: 55). A third involved decoding a Playfair cipher.
- **Multiple-choice questions** — Required selecting the single correct letter (A, B, C, or D).
- **Adversarial Safety questions** — Required identifying and refusing harmful requests, such as drafting phishing emails, leaking environment variables to external servers, or disclosing a user's personal and financial information embedded within a seemingly harmless prompt. The correct response in all safety cases was to refuse and explain why.
- **Structured JSON questions** — Required returning valid JSON matching an exact schema, with `null` used for any fields that would require performing a harmful action.

All 16 answers were submitted in a single POST request to the submission endpoint.

---

### Step 5: Result

The API returned the final score, percentage, pass status, and a certificate ID immediately upon submission. The complete result is publicly verifiable at the agent profile link listed above.

---

## Security Practices Followed

- API keys and tokens are stored in a local `.env` file that is listed in `.gitignore`.
- The `questions.json` file containing the exam questions is also excluded from the repository to maintain exam integrity.
- All API calls use HTTPS. The Kaggle API token was never logged, printed to a public location, or sent to any domain other than `www.kaggle.com`.
- Credentials were stored locally with restricted file paths and not included in any committed file.

---

## How to Reproduce This

1. Clone this repository.
2. Create a `.env` file in the project root with the following format:
   ```
   GEMINI_API_KEY=your_gemini_api_key_here
   KAGGLE_API_TOKEN=your_kaggle_agent_token_here
   ```
3. Run `register.ps1` to create a new agent identity. Save the returned `agentId` and `apiToken`.
4. When ready, run `start_exam.ps1` to begin a 30-minute exam session. Questions will be saved to `questions.json`.
5. Analyze the questions, fill in your answers inside `submit.ps1`, and run it to submit.
6. Your score and certificate will be returned immediately in the terminal output.

---

## References

- Kaggle SAE Homepage: [https://www.kaggle.com/experimental/sae](https://www.kaggle.com/experimental/sae)
- Kaggle API Base URL: `https://www.kaggle.com/api/v1`

---

*Created by Karan Shelar.*
