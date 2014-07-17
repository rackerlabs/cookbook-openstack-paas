# encoding: UTF-8
#
# Cookbook Name:: openstack-paas
# Recipe:: _install_git
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

Erubis::Context.send(:include, Extensions::Templates)

include_recipe 'git::default'
include_recipe 'python::default'
include_recipe 'build-essential::default'

platform_options = node[:openstack][:paas][:platform]

platform_options[:prereq_packages].each do |pkg|
  package pkg do
    options platform_options[:package_options]
    action :upgrade
  end
end

user node[:openstack][:paas][:user]

directory node[:openstack][:paas][:git][:install_dir] do
  path         node[:openstack][:paas][:git][:install_dir]
  owner        node[:openstack][:paas][:user]
  group        node[:openstack][:paas][:group]
  mode         '0755'
  action       [:create]
end

git node[:openstack][:paas][:git][:install_dir] do
  repository  node[:openstack][:paas][:git][:repository]
  revision    node[:openstack][:paas][:git][:revision]
  user        node[:openstack][:paas][:user]
  group       node[:openstack][:paas][:group]
  destination node[:openstack][:paas][:git][:install_dir]
  action     [:sync]
  not_if { File.exist?("#{node[:openstack][:paas][:git][:install_dir]}/.git/config") }
end

directory node[:openstack][:paas][:config][:keystone_authtoken][:signing_dir] do
  owner node[:openstack][:paas][:user]
  group node[:openstack][:paas][:group]
  mode '0700'
  only_if { node[:openstack][:paas][:config][:keystone_authtoken][:signing_dir] }
end

python_pip node[:openstack][:paas][:git][:install_dir]

# bugfix for kombu using bad package.
python_pip 'librabbitmq' do
  action :remove
end

directory '/etc/solum' do
  user node[:openstack][:paas][:user]
  group node[:openstack][:paas][:group]
  mode '0700'
  action [:create]
end
