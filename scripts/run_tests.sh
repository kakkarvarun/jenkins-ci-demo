#!/usr/bin/env bash
set -euo pipefail

OUT=$(bash app/app.sh)
echo "App says: $OUT"

grep -Eq "Hello from CI( \\(v2\\))?" <<< "$OUT"
echo "✅ Test passed"
