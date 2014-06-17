# Encoding: utf-8

default[:solum][:install_type] = 'git'
default[:solum][:install_dir] = '/opt/solum'
default[:solum][:user] = 'solum'
default[:solum][:group] = 'solum'
default[:solum][:git][:repository] = 'https://github.com/stackforge/solum.git'
default[:solum][:git][:revision] = 'master'
default[:solum][:required_packages] = ['libffi-dev']

default[:solum][:client][:install_dir] = '/opt/solumclient'
default[:solum][:client][:git][:repository] = 'https://github.com/stackforge/python-solumclient.git'
default[:solum][:client][:git][:revision] = 'master'

# hash of key/value pairs - see /opt/solum/etc/solum.conf.example
default[:solum][:config] = {
  default: {
    enable_authentication: 'true'
  },
  deployer: {
    handler: 'heat'
  },
  worker: {
    handler: 'shell'
  }
}
