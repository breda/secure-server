# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  # Ubuntu VM
  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "ubuntu/trusty64"
    ubuntu.vm.network "private_network", ip: "192.168.10.10"
  end

  # CentOS VM
  config.vm.define "centos" do |centos|
    centos.vm.box = "centos/7"
    centos.vm.network "private_network", ip: "192.168.10.11"
  end
end
