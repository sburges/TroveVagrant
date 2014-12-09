# -*- mode: ruby -*-
# vi: set ft=ruby :

# Set the amount of RAM you want to allocate to the VM. The default
# (3G) is the minimum, set this to higher if you have RAM to spare
ram = 10072
cpu = 2

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "trusty-server-amd64"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vmwarefusion.box"

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  #config.vm.network :private_network, ip: "192.168.122.111"

  # Set the hostname
  config.vm.hostname = "devstack"

  # Configure the synced folder to use rsync instead of the default
  # (so the "libvirt" provider doesn't need to mess with NFS)
  #config.vm.synced_folder "/Users/shayneburgess/workspace/nova", "/opt/stack/nova", create: true, type: "rsync", rsync__exclude: [".tox/"]
  #config.vm.synced_folder "/Users/shayneburgess/workspace/dev-platform-tools", "/opt/dev-platform-tools", create: true, type: "rsync", rsync__exclude: [".vagrant/"]
  #config.vm.synced_folder "/Users/shayneburgess/workspace/dbaas-installer", "/opt/dbaas-installer", create: true, type: "rsync"
  #config.vm.synced_folder "/Users/shayneburgess/workspace/als-installer", "/opt/als-installer", create: true, type: "rsync"
  #config.vm.synced_folder "/Users/shayneburgess/workspace/dev-platform-installer", "/opt/dev-platform-installer", create: true, type: "rsync"
  #config.vm.synced_folder "/Users/shayneburgess/workspace/dbaas-heat-templates", "/opt/stack/dbaas-heat-templates", create: true, type: "rsync"
  #config.vm.synced_folder "/Users/shayneburgess/workspace/dbaas-image-elements", "/opt/stack/dbaas-image-elements", create: true, type: "rsync"
  #config.vm.synced_folder "/Users/shayneburgess/workspace/als-image-elements", "/opt/stack/als-image-elements", create: true, type: "rsync"
  #config.vm.synced_folder "/Users/shayneburgess/workspace/paas-tools", "/opt/stack/paas-tools", create: true, type: "rsync"
  #config.vm.synced_folder "/Users/shayneburgess/workspace/paas-image-elements", "/opt/stack/paas-image-elements", create: true, type: "rsync"
  #config.vm.synced_folder "/Users/shayneburgess/workspace/sherpa", "/opt/stack/sherpa", create: true, type: "rsync"
  #config.vm.synced_folder "/Users/shayneburgess/workspace/sherpa-ui", "/opt/stack/sherpa-ui", create: true, type: "rsync"
  #config.vm.synced_folder "/Users/shayneburgess/workspace/dev-platform-installer-ui", "/opt/stack/dev-platform-installer-ui", create: true, type: "rsync"
  #config.vm.synced_folder "/Users/shayneburgess/Library/Caches/pypi", "/tmp/pypi_cache", create: true
  #config.vm.synced_folder "/Users/shayneburgess/workspace/devstack", "/tmp/devstack", create: true, type: "rsync"
  config.vm.synced_folder "/Users/shayneburgess/gitrepos/trove", "/opt/stack/trove", create: true, type: "rsync"
  config.vm.synced_folder "/Users/shayneburgess/gitrepos/trove-integration", "/home/ubuntu/trove-integration", create: true, type: "rsync"

  # VirtualBox specific settings.
  config.vm.provider :virtualbox do |vb|
    # Boot with a GUI so you can see the screen. (Default is headless)
    vb.gui = true

    # Set the amount of memory specified above
    vb.memory = ram
  end

   config.vm.provider :vmware_fusion do |vmf, override|
    vmf.gui = "TRUE"
    vmf.vmx["memsize"] = ram
    vmf.vmx["numvcpus"] = cpu
  end

  # Run the provisioning script
  config.vm.provision "shell", path: "provision-root.sh", args: [ENV.fetch('HOST_IP', '0.0.0.0'), ENV.fetch('ENABLE_CACHE','false')]

end
