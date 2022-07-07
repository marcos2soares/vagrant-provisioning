
kubectl create ns app-prd


kubectl create -f ./abacate.yaml   -n app-prd
kubectl create -f ./banana.yaml   -n app-prd

kubectl create -f ingress-app-prd.yaml  -n app-prd
