# -*- mode: ruby -*-
# vi: set ft=ruby :

# Install required vagrant plugins:
required_plugins = %w[nugrant vagrant-reload vagrant-persistent-storage vagrant-vbguest]
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
  extra_vars = "{"
  config.user.user_vars.each do |key, value|
    extra_vars += "'#{key}':'#{value}',"
  end
  extra_vars += "'user':'#{config.user.user}'}"

  # VM Configuration
  config.vm.box = "ubuntu/jammy64" # Ubuntu 20.04 64-bit

  config.vm.provider :virtualbox do |v|
    v.memory = 8192 # 4GB Memory
    v.cpus = 6
    v.customize ["modifyvm", :id, "--vram", "128"] # 128 MB Video Memory
    v.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
    v.customize ['modifyvm', :id, '--draganddrop', 'bidirectional']
    if not ENV['SYTUP_CI'] == 'true' then
      v.customize ['modifyvm', :id, '--nested-hw-virt', 'on']
      v.customize ["modifyvm", :id, "--usb", "on"] # Enable USB
      v.customize ["modifyvm", :id, "--usbxhci", "on"] # Enable USB3
      v.customize ['modifyvm', :id, '--graphicscontroller', 'vmsvga']
      v.customize ['modifyvm', :id, '--accelerate3d', 'on'] # Enable 3D Acceleration
      v.gui = false # Headless for CI
    else
      v.gui = true 
    end
  end

  if not ENV['SYTUP_CI'] == 'true' then
    # Increase Disk Size from 40GB to 200GB
    config.vm.disk :disk, size: "200GB", primary: true
  end

  config.persistent_storage.enabled = false
  config.persistent_storage.location = "D:/VirtualBox VMs/dev_persistent.vdi"
  config.persistent_storage.size = 200000
  config.persistent_storage.mountname = 'dev'
  config.persistent_storage.filesystem = 'ext4'
  config.persistent_storage.mountpoint = '/home/gp/dev'
  config.persistent_storage.diskdevice = '/dev/sdc'

  # Disable auto update of virtualbox guest additions - as of now it does not
  # detect them as running and tries to re-install them on each boot
  config.vbguest.auto_update = false

  # set extra boot time for testing on slow machines:
  config.vm.boot_timeout = 1800

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