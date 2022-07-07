#!/bin/bash
export USU=msoares
export KUBECONFIG=/home/$USU/.kube/config

green=`tput setaf 2`
reset=`tput sgr0`

echo "${green}Add apt repo for kubernetes${reset}"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg |  apt-key add -  
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" 

echo "${green}Install Kubernetes component (kubectl)${reset}"
apt install -qq -y kubectl=1.20.5-00  

 

echo "${green}Add Nodes /etc/hosts ${reset}"
if ! (grep kmaster /etc/hosts > /dev/null)
then
  echo "${green}Update /etc/hosts file${reset}"
cat >>/etc/hosts<<EOF
172.16.16.100   kmaster.example.com     kmaster
172.16.16.101   kworker1.example.com    kworker1
172.16.16.102   kworker2.example.com    kworker2
172.16.16.103   kworker3.example.com    kworker3
172.16.16.151   kstorage1.example.com    kstorage1
172.16.16.152   kstorage2.example.com    kstorage2
172.16.16.153   kstorage3.example.com    kstorage3

EOF

fi

rm -f /root/.ssh/known_hosts /home/$USU/.kube/config
echo "${green}Get kubernetes config of ControlPlane${reset}"
mkdir -p /home/$USU/.kube
sshpass -p  kubeadmin scp -o StrictHostKeyChecking=no root@kmaster:/etc/kubernetes/admin.conf /home/$USU/.kube/config
chown -R $USU:$USU /home/$USU/.kube


echo "${green}Install Helm${reset}"
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" |  tee /etc/apt/sources.list.d/helm-stable-debian.list
apt-get update  && apt-get install -qq -y helm

# Install Kubernetes Add-on

./add-on/metallb.sh
./add-on/nginxingress.sh
./add-on/dashboard.sh
./add-on/metrics.sh
./add-storage/longhorn.sh
./add-on/monitoring.sh
