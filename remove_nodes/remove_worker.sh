

#kubectl get nodes
#Drain it

#kubectl drain nodetoberemoved

#Delete it

#kubectl delete node nodetoberemoved

#On Worker Node (nodetoberemoved). Remove join/init setting from node

#kubeadm reset


kubectl get nodes -o wide
kubectl drain kworker3 --ignore-daemonsets
kubectl delete node kworker3
