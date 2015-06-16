# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure('2') do |config|
  config.vm.box      = 'ubuntu/trusty64'
  config.vm.hostname = 'lamp-dev-box'
  config.vm.synced_folder 'public', '/vagrant/public'

  config.vm.network :forwarded_port, guest: 80, host: 8888
  config.vm.network :forwarded_port, guest: 3306, host: 8889

  config.vm.provision :shell, path: 'bootstrap.sh', keep_color: true
end
