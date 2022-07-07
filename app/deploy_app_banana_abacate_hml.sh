
kubectl create ns app-hml


kubectl create -f ./abacate.yaml   -n app-hml
kubectl create -f ./banana.yaml   -n app-hml

kubectl create -f ingress-app-hml.yaml  -n app-hml
