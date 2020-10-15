# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "vagrant-ansible" do |ansible|
    ansible.vm.box = "centos/7"
    ansible.vm.hostname = "vagrant-ansible"
    ansible.vm.provider "virtualbox"
    ansible.ssh.username = "vagrant"

    ansible.vm.network "forwarded_port", guest: 8080, host: 8080
    ansible.vm.network "forwarded_port", guest: 80, host: 80

    ansible.ssh.insert_key = false
    ansible.ssh.private_key_path = [
      '~/.vagrant.d/insecure_private_key',
      '/home/alexandermedvedev/.ssh/id_rsa'
    ]

    ansible.vm.provision "file", source: "/home/alexandermedvedev/.ssh/id_rsa.pub", destination: "/tmp/aimedvedev.pub"

    ansible.vm.provision "shell", inline: <<-SHELL
      cat /tmp/aimedvedev.pub >> /home/vagrant/.ssh/authorized_keys
    SHELL
  end

end
