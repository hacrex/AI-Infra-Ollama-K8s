# Ingress Guidance

The base Kustomize path deliberately does not create public ingress. The former copied hostname and certificate references were removed because they do not belong to a reusable reference deployment.

Use `examples/ingress.yaml.example` only as a starting point for an environment-specific overlay. Before exposing Open WebUI, configure TLS, authentication, approved DNS ownership, rate limits, audit logging, and an ingress policy that matches your cluster. The included NetworkPolicy restricts ingress to the Ollama API so Open WebUI is the in-namespace caller.
