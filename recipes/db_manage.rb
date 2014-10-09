# encoding: UTF-8
#
# Cookbook Name:: openstack-paas
# Recipe:: db_manage
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

execute "#{node[:openstack][:paas][:install_dir]}/bin/solum-db-manage --config-file=/etc/solum/solum.conf upgrade head" do
  user node[:openstack][:paas][:user]
  group node[:openstack][:paas][:group]
  only_if { node[:openstack][:db][:paas][:migrate] }
end
