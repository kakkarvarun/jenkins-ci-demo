#!/usr/bin/env bash
set -euo pipefail

OUT=$(bash app/app.sh)
echo "App says: $OUT"

grep -q "Hello from CI" <<< "$OUT"
echo "✅ Test passed"
