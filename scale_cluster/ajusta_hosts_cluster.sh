#!/bin/bash
set -x
export USU=msoares
export KUBECONFIG=/home/$USU/.kube/config

green=`tput setaf 2`
reset=`tput sgr0`

echo "${green}Remove Nodes /etc/hosts ${reset}"
if  (grep kmaster /etc/hosts > /dev/null)
then
    grep -v -E "kmaster|kworker" /etc/hosts > /tmp/hosttmp
    cp /tmp/hosttmp /etc/hosts

fi


echo "${green}Add Nodes /etc/hosts ${reset}"
if ! (grep kmaster /etc/hosts > /dev/null)
then
  echo "${green}Update /etc/hosts file${reset}"
cat >>/etc/hosts<<EOF
172.16.16.100   kmaster.example.com     kmaster
172.16.16.101   kworker1.example.com    kworker1
172.16.16.102   kworker2.example.com    kworker2
172.16.16.103   kworker3.example.com    kworker3
172.16.16.104   kworker3.example.com    kworker4
EOF
fi


echo "${green}Add Nodes /etc/hosts on kubernetes Nodes${reset}"
for i in kmaster kworker1 kworker2 kworker3 kworker4
do

 echo $i 
 sshpass -p "kubeadmin" ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@$i  "grep -v -E \"kmaster|kworker\" /etc/hosts > /tmp/hosttmp"
 sshpass -p "kubeadmin" ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@$i  "cp  /tmp/hosttmp /etc/hosts"
 sshpass -p "kubeadmin" ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@$i  "   
cat >> /etc/hosts<<EOF
172.16.16.100   kmaster.example.com     kmaster
172.16.16.101   kworker1.example.com    kworker1
172.16.16.102   kworker2.example.com    kworker2
172.16.16.103   kworker3.example.com    kworker3
172.16.16.104   kworker3.example.com    kworker4
EOF"

done
