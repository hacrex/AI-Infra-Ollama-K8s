# GPU Readiness and Model Bootstrap

The `overlays/gpu` configuration requests one `nvidia.com/gpu` and selects nodes labelled `accelerator=nvidia`. It must not be applied to a generic Kubernetes cluster.

## Preflight

```bash
./scripts/preflight-gpu.sh
kubectl kustomize overlays/gpu
```

The preflight checks the active context, node label, allocatable GPU capacity, running device-plugin signal, and storage classes. It does not install drivers, label nodes, or modify the cluster.

## Model bootstrap

The base deployment includes a small sidecar that waits for the Ollama API to become reachable, then pulls `llama3.2`. The sidecar and Ollama container share the Pod network namespace, which makes `localhost:11434` appropriate after the API is ready. The model pull may take significant time and storage; observe pod logs and PVC capacity before treating the deployment as ready for user traffic.

## Baseline to record

For one non-sensitive prompt set, record the cluster type, CPU or GPU profile, model name, concurrent requests, response latency, pod memory use, and failure rate. Do not claim GPU acceleration or production inference performance until you have recorded a run.
