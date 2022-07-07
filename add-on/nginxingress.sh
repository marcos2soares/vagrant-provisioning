helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

kubectl create ns ingress-nginx

helm install ingress-nginx ingress-nginx/ingress-nginx -n ingress-nginx --values ./add-on/ingress-nginx.yaml


kubectl create ns ingress-nginx-prd

helm install ingress-nginx-prd ingress-nginx/ingress-nginx -n ingress-nginx-prd --values ./add-on/ingress-nginx-prd.yaml


