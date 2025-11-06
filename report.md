# Report: Jenkins + GitHub Integration (Polling)

**Student:** Varun Kakkar  
**Repo:** https://github.com/kakkarvarun/jenkins-ci-demo  
**Jenkins Job:** `ci-demo`  
**Approach Chosen:** **Polling** via `pollSCM('H/5 * * * *')`

## How it integrates
- Jenkins Pipeline job uses **Pipeline script from SCM (Git)** to pull this repo’s `main` branch.
- Jenkins polls GitHub every ~5 minutes. If a new commit exists, Jenkins clones the repo and runs stages:
  1) **Checkout** – `checkout scm`
  2) **Build** – simulated build steps using `sh` (echo + sleep)
  3) **Test** – runs `scripts/run_tests.sh` which calls `app/app.sh` and verifies output
  4) **Notification** – console echo, and email via Jenkins Mailer (Gmail/MailHog)

## What change triggered the build
- Commit: `docs: add line to trigger polling-based build` in `README.md`.
- Evidence: See GitHub **Commits** page and the commit diff.

## Challenges & Resolutions
- **Jenkinsfile parse error (missing brace / quoting):**  
  Replaced multiline `sh ''' ... '''` with single-line `sh '...'` and verified all closing braces.
- **Windows line endings causing bash issues:**  
  Added `sed -i "s/\r$//" scripts/run_tests.sh app/app.sh` before execution.
- **SMTP connection refused (if faced):**  
  Option A: Used Gmail **App Password** with TLS 587.  
  Option B: Used **MailHog** (`mailhog:1025`) locally to capture emails for the lab.
- **Git inside container:**  
  Built Jenkins image with `apt-get install -y git` to ensure checkout works.

## Validation
- Manual build succeeded (Build Now).
- Poll SCM detected the README change: **“Started by an SCM change”**; pipeline executed **Checkout → Build → Test → Post** successfully.
- Email notification worked (Gmail inbox or visible in MailHog UI).


