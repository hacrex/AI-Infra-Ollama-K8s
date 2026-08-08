# Running Ollama and Open WebUI in a Kubernetes Cluster


Running Ollama and Open WebUI in a Kubernetes Cluster

## Prerequisite

- Docker Desktop
- Enable Kubernetes under Settings > Kubernetes

## Clone the repository

```
git clone https://github.com/ajeetraina/ollama-openwebui-kubernetes
cd ollama-openwebui-kubernetes
```

## Apply the Kubernetes Manifest

```
kubectl apply -f ./
```

## Listing the Kubernetes Pods

```
kubectl get po -A
NAMESPACE              NAME                                         READY   STATUS    RESTARTS   AGE
kube-system            coredns-55cb58b774-n5v46                     1/1     Running   0          85m
kube-system            coredns-55cb58b774-snwn9                     1/1     Running   0          85m
kube-system            etcd-docker-desktop                          1/1     Running   1          85m
kube-system            kube-apiserver-docker-desktop                1/1     Running   1          85m
kube-system            kube-controller-manager-docker-desktop       1/1     Running   1          85m
kube-system            kube-proxy-t9vf4                             1/1     Running   0          85m
kube-system            kube-scheduler-docker-desktop                1/1     Running   1          85m
kube-system            storage-provisioner                          1/1     Running   0          85m
kube-system            vpnkit-controller                            1/1     Running   0          85m
kubernetes-dashboard   dashboard-metrics-scraper-7cbc78bdc6-8kv8d   1/1     Running   0          80m
kubernetes-dashboard   kubernetes-dashboard-7d748f6c6b-nfsjz        1/1     Running   0          80m
ollama                 ollama-56c4986548-qk2r6                      2/2     Running   0          84m
ollama                 open-webui-85799c995c-zxhgf                  1/1     Running   0          84m
```



## Accessing the Open Web UI

```
kubectl port-forward svc/svc-open-webui 8080:8080 -n ollama
```

## Open Open WebUI

Open [http://localhost:8080](http://localhost:8080) to access Open WebUI.

<img width="1185" alt="image" src="https://github.com/user-attachments/assets/e63a6d5d-9655-4ed2-b39b-2db019eca626">

## Pull a model

<img width="655" alt="image" src="https://github.com/user-attachments/assets/243fd811-b382-41c0-9e54-febc636c646b">

## Configuration Setting

Disable OpenAI and enable Ollama configuration by modifying it to http://localhost:11434

<img width="1236" alt="image" src="https://github.com/user-attachments/assets/ea8f0e9c-4d45-4980-ab54-9b93ce2a588b">

