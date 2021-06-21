# -*- mode: ruby -*-
# vi: set ft=ruby :

# Install required vagrant plugins:
required_plugins = %w[nugrant vagrant-reload]
plugins_to_install = required_plugins.reject { |plugin| Vagrant.has_plugin? plugin }
unless plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort 'Installation of one or more plugins has failed. Aborting.'
  end
end

# Configure VM
Vagrant.configure("2") do |config|

  # Default values can be overwritten with .vagrantuser. See .vagrantuser.example
  config.user.defaults = {
    "user" => "airborne", 
    "pwd" => "airborne",
    "user_repo" => "https://github.com/gregerspoulsen/sys-setup-gp.git",
    "host_mount" => false, # Map host folder at ~/sytup/
    "user_vars" => {}
  }

  # Build extra_vars for ansible provisioning:
  extra_vars = ""
  config.user.user_vars do |key, value|
    extra_vars += "#{key}=#{value} "
  end
  extra_vars += "user=#{config.user.user}"

  # VM Configuration
  config.vm.box = "ubuntu/focal64" # Ubuntu 20.04 64-bit

  config.vm.provider :virtualbox do |v|
    v.gui = true # Display UI 
    v.memory = 4096 # 4GB Memory
    v.customize ["modifyvm", :id, "--vram", "128"] # 128 MB Video Memory
    v.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
    v.customize ['modifyvm', :id, '--draganddrop', 'bidirectional']
  end

  # Basic Ubuntu Setup with UI:
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "sys_bootstrap/system_bootstrap.yaml"
    ansible.provisioning_path = "/vagrant/"
    ansible.extra_vars = {
      user: config.user.user,
      pwd: config.user.pwd
    }
  end
  
  # Mount host dir if set:
  if config.user.host_mount then
    config.vm.synced_folder "../", "/home/"+config.user.user+"/sytup"
  end
  
  # Run sytup Bootstrap:
  config.vm.provision "shell",
    path: "bootstrap.sh",
    args: [config.user.user, config.user.user_repo, extra_vars]


  config.vm.provision :reload
end