# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_EXPERIMENTAL="dependency_provisioners"
ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|

  config.vm.provision "shell", path: "bootstrap.sh"

  # Kubernetes Master Server
  config.vm.define "kmaster" do |node|
  
    node.vm.box = "generic/ubuntu2004"
    node.vm.box_check_update = false
    node.vm.box_version = "3.2.12"
    node.vm.hostname = "kmaster.example.com"
    node.vm.network "private_network", ip: "172.16.16.100"
  
    node.vm.provider "virtualbox" do |v|
      v.name = "kmaster"
      v.memory = 8192
      v.cpus = 4
    end
  
  
    node.vm.provision "shell", path: "bootstrap_kmaster.sh"
  
  end


  # Kubernetes Worker Nodes
  NodeCount = 3

  (1..NodeCount).each do |i|

    config.vm.define "kworker#{i}" do |node|

      node.vm.box = "generic/ubuntu2004"
      node.vm.box_check_update = false
      node.vm.box_version = "3.2.12"
      node.vm.hostname = "kworker#{i}.example.com"
      node.vm.network "private_network", ip: "172.16.16.10#{i}"

      node.vm.provider "virtualbox" do |v|
        v.name = "kworker#{i}"
        v.memory = 5096
        v.cpus = 4
      end


      node.vm.provision "shell", path: "bootstrap_kworker.sh"

    end

  end

end
