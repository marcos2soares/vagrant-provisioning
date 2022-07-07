#!/bin/bash

echo "[TASK 1] Join node to Kubernetes Cluster"
apt install -qq -y sshpass >/dev/null 2>&1
sshpass -p "kubeadmin" ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@kmaster.example.com "kubeadm token create --print-join-command" > /joincluster.sh 2>/dev/null
bash /joincluster.sh >/dev/null 2>&1
