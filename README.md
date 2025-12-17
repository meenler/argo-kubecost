# BDMS Kubecost - Helm DevOps

Kubecost deployment ผ่าน ArgoCD สำหรับทุก environment (Dev, UAT, Production)

## 📁 โครงสร้าง

```
bdms-helm-devops/
├── argocd-applications/          # ArgoCD Application manifests
│   ├── kubecost-dev.yaml        # → Dev environment
│   ├── kubecost-uat.yaml        # → UAT environment
│   └── kubecost-prod.yaml       # → Production environment
│
├── charts/
│   ├── kubecost/                # Kubecost Helm Chart
│   │   ├── Chart.yaml           # Chart metadata
│   │   ├── values.yaml          # Default values (base)
│   │   ├── templates/           # Kubernetes manifests templates
│   │   ├── charts/              # Sub-charts (finops-agent)
│   │   └── crds/                # Custom Resource Definitions
│   │
│   └── values/
│       └── kubecost/            # Environment-specific values
│           ├── value-dev.yml    # Dev configuration
│           ├── value-uat.yml    # UAT configuration
│           └── value-prod.yml   # Production configuration
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

## 🚀 การ Deploy

### Deploy แยกตาม environment:
```bash
# Development
kubectl apply -f argocd-applications/kubecost-dev.yaml

# UAT
kubectl apply -f argocd-applications/kubecost-uat.yaml

# Production
kubectl apply -f argocd-applications/kubecost-prod.yaml
```

### Deploy ทั้งหมดพร้อมกัน:
```bash
kubectl apply -f argocd-applications/
```

## 🔗 การเข้าถึง

| Environment | URL | Service Type | Namespace |
|-------------|-----|--------------|-----------|
| **Dev** | `http://localhost:<nodeport>` | NodePort | kubecost |
| **UAT** | https://kubecost-uat.bdms.tech | LoadBalancer | kubecost-uat |
| **Prod** | https://kubecost.bdms.tech | LoadBalancer | kubecost-prod |

### ตรวจสอบ Service (Dev):
```bash
kubectl get svc -n kubecost
```

## 📝 การแก้ไข Configuration

1. แก้ไขไฟล์ values ที่ต้องการ:
   - `charts/values/kubecost/value-dev.yml`
   - `charts/values/kubecost/value-uat.yml`
   - `charts/values/kubecost/value-prod.yml`

2. Commit และ push การเปลี่ยนแปลง

3. ArgoCD จะ sync อัตโนมัติ (หรือ manual sync ใน ArgoCD UI)

## 🛠️ การจัดการ

### ตรวจสอบสถานะ ArgoCD:
```bash
kubectl get applications -n argocd
```

### ดู logs:
```bash
# Dev
kubectl logs -n kubecost -l app=kubecost

# UAT
kubectl logs -n kubecost-uat -l app=kubecost

# Prod
kubectl logs -n kubecost-prod -l app=kubecost
```

### Force sync (manual):
```bash
# ใช้ ArgoCD CLI
argocd app sync kubecost-dev
argocd app sync kubecost-uat
argocd app sync kubecost-prod
```
