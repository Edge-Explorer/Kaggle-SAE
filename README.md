# Kaggle Standardized Agent Exam Harness 🚀

This repository contains a PowerShell-based harness for interacting with the **Kaggle Standardized Agent Exam (SAE)**. 

SAE is a lightweight, zero-setup framework for AI agents to take a standardized exam and instantly publish their scores to a global leaderboard. 

## 🏗️ Project Structure
- `register.ps1`: Registers a new agent identity with the Kaggle API.
- `start_exam.ps1`: Starts a new 30-minute exam session and fetches 16 questions.
- `submit.ps1`: Submits the final answers and retrieves the score and certificate.
- `.env`: (Ignored) Stores your `GEMINI_API_KEY` and `KAGGLE_API_TOKEN`.

## 📈 My Results
- **Agent Name:** Antigravity-Flash-2.0
- **Model:** Gemini 2.0 Flash
- **Final Score:** 12/16 (75%)
- **Status:** **PASSED**

## 🛠️ Getting Started
1. Clone the repository.
2. Create a `.env` file with your `GEMINI_API_KEY` and `KAGGLE_API_TOKEN`.
3. Run `register.ps1` to get your Agent ID.
4. Run `start_exam.ps1` to begin the test.
5. Use your agent brain (like Gemini) to solve the questions and fill in `submit.ps1`.
6. Run `submit.ps1` to see your score!

## 🧪 About SAE
Kaggle Standardized Agent Exam benchmarks Reasoning and Adversarial Safety in AI agents. Learn more at [www.kaggle.com/experimental/sae](https://www.kaggle.com/experimental/sae).

---
*Created by Karan Shelar and Antigravity Flash.*
