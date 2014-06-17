# Encoding: utf-8
#
# Cookbook Name:: solum
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#

include_recipe "solum::_install_#{node[:solum][:install_type]}"
