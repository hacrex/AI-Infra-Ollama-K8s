#!/usr/bin/env bash
set -euo pipefail

LABEL_SELECTOR="${GPU_NODE_SELECTOR:-accelerator=nvidia}"
NAMESPACE="${NAMESPACE:-ollama}"

command -v kubectl >/dev/null 2>&1 || {
  echo "kubectl is required." >&2
  exit 127
}

printf 'Current context: '
kubectl config current-context

NODES="$(kubectl get nodes -l "$LABEL_SELECTOR" -o name)"
test -n "$NODES" || {
  echo "No nodes match label selector: $LABEL_SELECTOR" >&2
  echo "Label a tested GPU node before applying the GPU overlay." >&2
  exit 1
}

printf '\nGPU candidate nodes:\n%s\n' "$NODES"
for node in $NODES; do
  name="${node#node/}"
  allocatable="$(kubectl get "$node" -o jsonpath='{.status.allocatable.nvidia\.com/gpu}' 2>/dev/null || true)"
  printf '%s allocatable nvidia.com/gpu: %s\n' "$name" "${allocatable:-0}"
  test -n "$allocatable" && test "$allocatable" != "0" || {
    echo "Node $name does not advertise a usable GPU resource." >&2
    exit 1
  }
done

printf '\nChecking for an NVIDIA device-plugin pod...\n'
kubectl get pods -A --no-headers | grep -Eiq 'nvidia.*device-plugin|nvidia-device-plugin.*running' || {
  echo "No running NVIDIA device-plugin pod was found." >&2
  exit 1
}

printf '\nChecking storage classes for the Ollama PVC...\n'
kubectl get storageclass
printf '\nGPU preflight passed. Render next with: kubectl kustomize overlays/gpu\n'
