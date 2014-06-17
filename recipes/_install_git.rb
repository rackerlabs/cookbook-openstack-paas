# Encoding: utf-8
#
# Cookbook Name:: paas_solum
# Recipe:: git
#
# Copyright (C) 2013 Rackspace
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'git::default'
include_recipe 'python::default'
include_recipe 'build-essential::default'

node[:solum][:required_packages].each do |pkg|
  package pkg
end

%w(pecan WSME).each do |pip|
  python_pip pip do
    package_name  pip
    action        [:install]
  end
end

user 'solum'

directory node[:solum][:install_dir] do
  path         node[:solum][:install_dir]
  owner        node[:solum][:user]
  group        node[:solum][:group]
  mode         '0755'
  action       [:create]
end

git node[:solum][:install_dir] do
  repository  node[:solum][:git][:repository]
  revision    node[:solum][:git][:revision]
  user        node[:solum][:user]
  group       node[:solum][:group]
  destination node[:solum][:install_dir]
  action     [:sync]
  not_if { File.exist?("#{node[:solum][:install_dir]}/.git/config") }
end

python_pip node[:solum][:install_dir]

directory node[:solum][:client][:install_dir] do
  path         node[:solum][:client][:install_dir]
  owner        node[:solum][:user]
  group        node[:solum][:group]
  mode         '0755'
  action       [:create]
end

git node['solum']['client']['install_dir'] do
  repository  node['solum']['client']['git']['repository']
  revision    node['solum']['client']['git']['revision']
  user        node['solum']['user']
  group       node['solum']['group']
  destination node['solum']['client']['install_dir']
  action     [:sync]
  not_if { File.exist?("#{node['solum']['client']['install_dir']}/.git/config") }
end

python_pip node['solum']['client']['install_dir']

directory '/etc/solum' do
  user node[:solum][:user]
  group node[:solum][:group]
  mode '0700'
  action [:create]
end

Erubis::Context.send(:include, Extensions::Templates)

template '/etc/solum/solum.conf' do
  user node[:solum][:user]
  group node[:solum][:group]
  mode '0700'
  variables solum_config: node[:solum][:config]
  action [:create]
end

include_recipe 'runit::default'

runit_service 'solum-api' do
  default_logger true
  options(
    user: node[:solum][:user],
    group: node[:solum][:group],
    home: node[:solum][:client][:install_dir]
  )
end
