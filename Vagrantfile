# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64" # Ubuntu 20.04 64-bit

  
  config.vm.provider :virtualbox do |v|
    v.gui = true # Display UI
    v.memory = 4096 # 4GB Memory
    v.customize ["modifyvm", :id, "--vram", "128"] # 128 MB Video Memory
  end

  # Provision machine with ansible:
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "sys_bootstrap/ubuntu_bootstrap.yaml"
    ansible.provisioning_path = "/vagrant/"
  end

  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "sys_bootstrap/user.yaml"
    ansible.provisioning_path = "/vagrant/"
    ansible.extra_vars = {
      user: "gp",
      pwd: "test"
    }
  end
end

