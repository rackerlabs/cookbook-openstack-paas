# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.hostname = 'solum'
  config.vm.box = 'ubuntu-12.04'
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_#{config.vm.box}_chef-provisionerless.box"
  config.omnibus.chef_version = 'latest'
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      openstack: {
        paas: {
          runit_services: ['solum-api']
        }
      }
      [:openstack][:paas][:runit_services]
    }

    chef.run_list = [
        'recipe[apt::default]',
        'recipe[openstack-paas::server]',
        'recipe[openstack-paas::identity_register]',
        'recipe[openstack-paas::client]',
        'recipe[openstack-common::openrc]'
    ]
  end
end
