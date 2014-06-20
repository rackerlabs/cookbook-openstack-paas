# Encoding: utf-8
require 'rspec/expectations'
require 'chefspec'
require 'chefspec/berkshelf'
require 'chef/application'

# ChefSpec::Coverage.start! { add_filter 'openstack-paas' }

::LOG_LEVEL = :fatal
::UBUNTU_OPTS = {
  platform: 'ubuntu',
  version: '12.04',
  log_level: ::LOG_LEVEL
}
::CHEFSPEC_OPTS = {
  log_level: ::LOG_LEVEL
}

shared_context 'stubs-common' do
  before do
    Chef::Recipe.any_instance.stub(:rabbit_servers)
      .and_return '1.1.1.1:5672,2.2.2.2:5672'
    Chef::Recipe.any_instance.stub(:address_for)
      .with('lo')
      .and_return '127.0.1.1'
    Chef::Recipe.any_instance.stub(:search_for)
      .with('os-identity').and_return(
        [{
          'openstack' => {
            'identity' => {
              'admin_tenant_name' => 'admin',
              'admin_user' => 'admin'
            }
          }
        }]
      )
    Chef::Recipe.any_instance.stub(:db_uri)
      .with('paas', 'solum', 'solum')
      .and_return('sql://')
    Chef::Recipe.any_instance.stub(:get_password)
      .with('user', 'guest')
      .and_return('guest')
    Chef::Recipe.any_instance.stub(:get_password)
      .with('db', 'solum')
      .and_return('solum')
    Chef::Recipe.any_instance.stub(:get_password)
      .with('service', 'openstack-paas')
      .and_return('solum')
    Chef::Recipe.any_instance.stub(:endpoint)
      .with(anything)
      .and_return('http://127.0.0.1:8777')
    Chef::Recipe.any_instance.stub(:memcached_servers).and_return []
    Chef::Recipe.any_instance.stub(:auth_uri_transform)
      .with(anything, anything)
      .and_return('http://127.0.0.1:5000')
    Chef::Recipe.any_instance.stub(:db_create_with_user)
      .with(anything, anything, anything)
      .and_return(true)
  end
end

# at_exit { ChefSpec::Coverage.report! }
