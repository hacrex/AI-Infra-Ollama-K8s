# Ollama and Open WebUI on Kubernetes

Kubernetes manifests for running Ollama with Open WebUI. The base includes persistent storage, Services, health probes, a NetworkPolicy, and a Kustomize GPU overlay.

## Start with the base

```bash
./scripts/validate-manifests.sh
kubectl apply -k .
```

The base path does not publish a public ingress. Copy `examples/ingress.yaml.example` into an environment-specific overlay only after you have decided on DNS ownership, TLS, authentication, and ingress policy.

## GPU nodes

The GPU overlay selects nodes labelled `accelerator=nvidia` and requests `nvidia.com/gpu`.

```bash
./scripts/preflight-gpu.sh
kubectl kustomize overlays/gpu
kubectl apply -k overlays/gpu
```

The preflight only checks the current cluster; it does not install drivers or configure a device plugin. Record the model, concurrency, hardware profile, latency, and error rate before making any performance claim.

## Notes

The Open WebUI pod is the allowed caller of the Ollama API. The model bootstrap sidecar waits for the local Ollama endpoint, then pulls `llama3.2`. Model downloads can take time and storage, so check pod logs and PVC capacity before sending users to the UI.
