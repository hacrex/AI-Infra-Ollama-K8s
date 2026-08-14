#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

command -v kubectl >/dev/null 2>&1 || {
  echo "kubectl is required." >&2
  exit 127
}

for target in . overlays/gpu; do
  rendered="$(mktemp)"
  kubectl kustomize "$target" > "$rendered"
  grep -q 'kind: Deployment' "$rendered"
  grep -q 'kind: NetworkPolicy' "$rendered"
  if [ "$target" = "overlays/gpu" ]; then
    grep -q 'nvidia.com/gpu' "$rendered"
  fi
  rm -f "$rendered"
  printf 'Rendered %s successfully.\n' "$target"
done

if grep -R 'openbear' --exclude-dir=.git .; then
  echo "A copied host fragment remains in the repository." >&2
  exit 1
fi
