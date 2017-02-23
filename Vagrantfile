# -*- mode: ruby -*-
# vi: set ft=ruby :

##
# Customize VARS below
##
PROJECTS_GIT_HOME= File.expand_path "../"

PROJECTS = {
  :ansible_service_broker  => "#{PROJECTS_GIT_HOME}/ansible-service-broker",
  :ansibleapp           => "#{PROJECTS_GIT_HOME}/ansibleapp"
}

PROJECTS.each do |name, path|
  if !Dir.exists?(path)
    puts "Please ensure you have a #{name} git clone at: #{path}"
    exit
  end
end

##
# OPTIONAL Git Repos
##

Vagrant.configure("2") do |config|
  config.vm.hostname = "centos1.example.com"
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  config.vm.box = "centos/7"
  config.vm.provision :shell, :path => "setup.sh", :args => PROJECTS.values.join(' ')

  config.vm.synced_folder ".", "/vagrant", type: "nfs"

  PROJECTS.each do |name, path|
    type = :nfs
    config.vm.synced_folder path, path, type: type
  end

  config.vm.network :private_network,
    :ip => "192.168.155.5",
    :libvirt__netmask => "255.255.255.0",
    :libvirt__network_name => "centos_cluster_net",
    :libvirt__dhcp_enabled => false

  config.vm.provider :libvirt do |libvirt|
    libvirt.driver = "kvm"
    libvirt.memory = 16384
    libvirt.cpus = `grep -c ^processor /proc/cpuinfo`.to_i
    libvirt.volume_cache = 'unsafe'
  end

end
