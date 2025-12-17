# Kubecost Values Files

ไฟล์ values สำหรับแต่ละ environment

## Files

- **value-dev.yml** - Development environment configuration
- **value-uat.yml** - UAT environment configuration  
- **value-prod.yml** - Production environment configuration

## การใช้งาน

ไฟล์เหล่านี้จะถูกอ้างอิงโดย ArgoCD Applications ใน `argocd-applications/` directory

### ตัวอย่างการแก้ไข:

1. เปิดไฟล์ที่ต้องการแก้ไข
2. ปรับค่า configuration ตามต้องการ
3. Commit และ push
4. ArgoCD จะ sync อัตโนมัติ

## Configuration ที่สำคัญ

- **Resources** - CPU/Memory limits และ requests
- **Persistence** - การเก็บข้อมูลถาวร
- **Service** - ประเภท service (NodePort/LoadBalancer)
- **Ingress** - การตั้งค่า domain และ SSL
- **Replicas** - จำนวน pods (สำหรับ HA)
