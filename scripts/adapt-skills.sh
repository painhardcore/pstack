#!/bin/sh

set -eu

ROOT=$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)
exec python3 "$ROOT/scripts/adapt_skills.py" "${1:-$ROOT}"
