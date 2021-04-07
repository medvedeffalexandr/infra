clean:
	vagrant halt vagrant && vagrant destroy -f vagrant && vagrant global-status --prune
up:
	vagrant up
reload:
	vagrant reload vagrant --provision-with ansible
restart:
	vagrant halt vagrant && vagrant destroy -f vagrant && vagrant global-status --prune && vagrant up
