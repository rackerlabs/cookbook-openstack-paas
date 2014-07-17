# encoding: UTF-8
#
# Cookbook Name:: openstack-paas
# Recipe:: install
#
# Copyright 2014, Rackspace, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'uri'

class Chef
  class Recipe # rubocop:disable Documentation
    include ::Openstack
  end
end

if node[:openstack][:paas][:syslog][:use]
  include_recipe 'openstack-common::logging'
end

platform_options = node[:openstack][:paas][:platform]

db_type = node[:openstack][:db][:paas][:service_type]
unless db_type == 'sqlite'
  platform_options["#{db_type}_python_packages"].each do |pkg|
    package pkg do
      options platform_options[:package_options]
      action :upgrade
    end
  end
end

include_recipe "openstack-paas::_install_#{node[:openstack][:paas][:git][:install_type]}"

db_user = node[:openstack][:db][:paas][:username]
db_pass = node[:openstack][:db][:paas][:password] || get_password('db', 'solum')

sql_connection = node[:openstack][:db][:paas][:sql_connection] || db_uri('paas', db_user, db_pass)

mq_service_type = node[:openstack][:mq][:paas][:service_type]

if mq_service_type == 'rabbitmq'
  node[:openstack][:mq][:paas][:rabbit][:ha] && (rabbit_hosts = rabbit_servers)
  mq_password = node[:openstack][:mq][:paas][:rabbit][:password] || get_password('user', node[:openstack][:mq][:paas][:rabbit][:userid])
elsif mq_service_type == 'qpid'
  mq_password = node[:openstack][:mq][:paas][:qpid][:password] || get_password('user', node[:openstack][:mq][:paas][:qpid][:username])
end

identity_endpoint = endpoint 'identity-api'
identity_admin_endpoint = endpoint 'identity-admin'
service_pass = get_password 'service', 'openstack-paas'

auth_uri = auth_uri_transform identity_endpoint.to_s, node[:openstack][:paas][:api][:auth][:version]

template '/etc/solum/solum.conf' do
  source 'solum.conf.erb'
  user node[:openstack][:paas][:user]
  group node[:openstack][:paas][:group]
  mode '0600'
  variables(
    sql_connection: sql_connection,
    mq_password: mq_password,
    rabbit_hosts: rabbit_hosts,
    identity_endpoint: identity_endpoint,
    identity_admin_endpoint: identity_admin_endpoint,
    service_pass: service_pass,
    auth_uri: auth_uri
  )
  action [:create]
end
