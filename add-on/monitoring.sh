
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

kubectl create ns monitoring-system
helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring-system  --values ./add-on/monitoring.yaml


sleep 60

echo "
apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: prometheus-grafana
  namespace: monitoring-system
  annotations:
    kubernetes.io/ingress.class: "nginx-prd"
spec:
  rules:
  - host: grafana.kubeprd.msdigital.xyz
    http:
      paths:
      - path: /
        backend:
          serviceName: prometheus-grafana
          servicePort: 3000

" | kubectl -n monitoring-system  create -f -
