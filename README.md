# Kubecost Deployment Structure

This repository contains Kubecost Helm chart with multi-environment support.

## Structure

```
bdms-helm-devops/
├── argocd-applications/
│   ├── kubecost-dev.yaml       # Dev environment
│   ├── kubecost-uat.yaml       # UAT environment
│   └── kubecost-prod.yaml      # Production environment
├── kubecost/                    # Kubecost Helm Chart v3.0.6
└── values/
    └── kubecost/
        ├── value-dev.yml       # Dev configuration
        ├── value-uat.yml       # UAT configuration
        └── value-prod.yml      # Production configuration
```

## Environments

### Development
- **Namespace:** kubecost-dev (or kubecost)
- **Service:** NodePort
- **Resources:** Minimal (256Mi/100m)
- **Persistence:** Disabled
- **Auto-sync:** Enabled

### UAT
- **Namespace:** kubecost-uat
- **Service:** LoadBalancer
- **Resources:** Medium (512Mi/200m)
- **Persistence:** Enabled (10Gi)
- **Auto-sync:** Enabled
- **Ingress:** kubecost-uat.bdms.tech

### Production
- **Namespace:** kubecost-prod
- **Service:** LoadBalancer
- **Resources:** High (1Gi/500m)
- **Persistence:** Enabled (50Gi)
- **Auto-sync:** Self-heal only (no auto-prune)
- **High Availability:** 2 replicas
- **Ingress:** kubecost.bdms.tech

## Deployment

### Deploy specific environment:
```bash
# Development
kubectl apply -f argocd-applications/kubecost-dev.yaml

# UAT
kubectl apply -f argocd-applications/kubecost-uat.yaml

# Production
kubectl apply -f argocd-applications/kubecost-prod.yaml
```

### Deploy all environments:
```bash
kubectl apply -f argocd-applications/
```

## Access

### Development (NodePort)
```bash
kubectl get svc -n kubecost
# Access via http://localhost:<nodeport>
```

### UAT/Production (LoadBalancer)
- UAT: https://kubecost-uat.bdms.tech
- Production: https://kubecost.bdms.tech
