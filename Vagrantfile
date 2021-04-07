# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "vagrant" do |vagrant|
    vagrant.vm.box = "centos/7"
    vagrant.vm.hostname = "vagrant"
    vagrant.vm.provider "virtualbox"
    vagrant.ssh.username = "vagrant"

    vagrant.vm.network "forwarded_port", guest: 8080, host: 8080
    vagrant.vm.network "forwarded_port", guest: 80, host: 80

    vagrant.ssh.insert_key = false
    vagrant.ssh.private_key_path = [
      '~/.vagrant.d/insecure_private_key',
      '/home/alexandermedvedev/.ssh/id_rsa'
    ]

    vagrant.vm.provision "file", source: "/home/alexandermedvedev/.ssh/id_rsa.pub", destination: "/tmp/aimedvedev.pub"

    vagrant.vm.provision "shell", inline: <<-SHELL
      cat /tmp/aimedvedev.pub >> /home/vagrant/.ssh/authorized_keys
    SHELL
  end

end
