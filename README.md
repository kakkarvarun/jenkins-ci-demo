# Jenkins CI Demo (Polling)

Simple repo to demo Jenkins polling-based CI pipeline:
- Checkout
- Build (simulated)
- Test (simple bash script)
- Notification (console + optional email)
## How to run tests locally
bash scripts/run_tests.sh
### Change for polling demo
This line should trigger Jenkins via Poll SCM.

Trigger email test via polling.
