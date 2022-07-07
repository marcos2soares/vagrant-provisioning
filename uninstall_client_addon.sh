#!/bin/bash
export USU=msoares
export KUBECONFIG=/home/$USU/.kube/config

green=`tput setaf 2`
reset=`tput sgr0`

echo "${green}Remove apt repo for kubernetes${reset}"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg |  apt-key add -  
apt-remove-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" 

echo "${green}Remove Kubernetes component (kubectl)${reset}"
apt remove -qq -y kubectl=1.20.5-00  

 
echo "${green}Remove Nodes /etc/hosts ${reset}"
if  (grep kmaster /etc/hosts > /dev/null)
then
    grep -v -E "kmaster|kworker" /etc/hosts > /tmp/hosttmp
    cp /tmp/hosttmp /etc/hosts

fi

echo "${green}Remove kubernetes config ${reset}"
rm -f /root/.ssh/known_hosts /home/$USU/.kube/config
rm -rf /home/$USU/.kube /tmp/hosttmp


echo "${green}Uninstall Helm${reset}"
apt-get remove -qq -y  helm
