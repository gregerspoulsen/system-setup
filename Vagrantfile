# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64" # Ubuntu 20.04 64-bit

  # VM Configuration
  config.vm.provider :virtualbox do |v|
    v.gui = true # Display UI
    v.memory = 4096 # 4GB Memory
    v.customize ["modifyvm", :id, "--vram", "128"] # 128 MB Video Memory
  end

  # Basic Ubuntu Setup with UI:
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "sys_bootstrap/system_bootstrap.yaml"
    ansible.provisioning_path = "/vagrant/"
    ansible.extra_vars = {
      user: "airborne",
      pwd: "airborne"
    }
  end

  # Run sytup Bootstrap:
  config.vm.provision "shell", path: "bootstrap.sh"


end

