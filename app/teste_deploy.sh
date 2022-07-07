

kubectl create deploy nginx --image nginx
kubectl expose deploy nginx --port 80 --type LoadBalancer
kubectl get svc
#kubectl expose deploy nginx --port=8000 --target-port=80 --type LoadBalancer --name=nginxhttp1
