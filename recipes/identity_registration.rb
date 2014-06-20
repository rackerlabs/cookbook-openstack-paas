# encoding: UTF-8
#
# Cookbook Name:: openstack-paas
# Recipe:: identity_registration
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

identity_admin_endpoint = endpoint 'identity-admin'
bootstrap_token = get_secret 'openstack_identity_bootstrap_token'
auth_uri = ::URI.decode identity_admin_endpoint.to_s
service_pass = get_password 'service', 'openstack-paas'
service_user = node[:openstack][:paas][:service_user]
service_role = node[:openstack][:paas][:service_role]
service_tenant_name = node[:openstack][:paas][:service_tenant_name]
paas_api_endpoint = endpoint 'paas-api'
region = node[:openstack][:paas][:region]

# Register Service Tenant
openstack_identity_register 'Register Service Tenant' do
  auth_uri auth_uri
  bootstrap_token bootstrap_token
  tenant_name service_tenant_name
  tenant_description 'Service Tenant'

  action :create_tenant
end

# Register Service User
openstack_identity_register 'Register Service User' do
  auth_uri auth_uri
  bootstrap_token bootstrap_token
  tenant_name service_tenant_name
  user_name service_user
  user_pass service_pass

  action :create_user
end

## Grant Admin role to Service User for Service Tenant ##
openstack_identity_register "Grant 'admin' Role to Service User for Service Tenant" do
  auth_uri auth_uri
  bootstrap_token bootstrap_token
  tenant_name service_tenant_name
  user_name service_user
  role_name service_role

  action :grant_role
end

# Register paas Service
openstack_identity_register 'Register paas Service' do
  auth_uri auth_uri
  bootstrap_token bootstrap_token
  service_name 'solum'
  service_type 'application_deployment'
  service_description 'Solum'

  action :create_service
end

# Register Compute Endpoint
openstack_identity_register 'Register Compute Endpoint' do
  auth_uri auth_uri
  bootstrap_token bootstrap_token
  service_type 'application_deployment'
  endpoint_region region
  endpoint_adminurl ::URI.decode paas_api_endpoint.to_s
  endpoint_internalurl ::URI.decode paas_api_endpoint.to_s
  endpoint_publicurl ::URI.decode paas_api_endpoint.to_s

  action :create_endpoint
end
