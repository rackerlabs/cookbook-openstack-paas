# Encoding: utf-8

# The OpenStack PAAS (Solum) API endpoint
default[:openstack][:endpoints]['paas-api-bind'][:host] = node[:openstack][:endpoints]['bind-host']
default[:openstack][:endpoints]['paas-api-bind'][:port] = '9777'
default[:openstack][:endpoints]['paas-api-bind'][:bind_interface] = nil

default[:openstack][:endpoints]['paas-api-bind'][:host] = node[:openstack][:endpoints][:host]
default[:openstack][:endpoints]['paas-api-bind'][:scheme] = 'http'
default[:openstack][:endpoints]['paas-api-bind'][:port] = '9777'
default[:openstack][:endpoints]['paas-api-bind'][:path] = ''
default[:openstack][:endpoints]['paas-api-bind'][:bind_interface] = nil
