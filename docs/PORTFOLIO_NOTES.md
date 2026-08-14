# Portfolio Notes

## My focus

This repository lets me discuss practical private-LLM deployment concerns: persistent model storage, ingress exposure, CPU versus GPU scheduling, and the controls required before public access.

## Evidence I can show

- `kustomization.yaml` for the base deployment path.
- `overlays/gpu/gpu-patch.yaml` for GPU scheduling constraints.
- `pvc.yaml`, `services.yaml`, and `deployment.yaml` for runtime dependencies.

## Known boundary

The base is a CPU proof of concept. I would measure model latency, storage use, GPU utilisation, and authentication behaviour before describing it as a production AI platform.
