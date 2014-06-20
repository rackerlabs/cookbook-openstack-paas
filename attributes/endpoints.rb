# Encoding: utf-8

# The OpenStack Image (Glance) API endpoint
default['openstack']['endpoints']['paas-api-bind']['host'] = node['openstack']['endpoints']['bind-host']
default['openstack']['endpoints']['paas-api-bind']['port'] = '9777'
default['openstack']['endpoints']['paas-api-bind']['bind_interface'] = nil

default['openstack']['endpoints']['paas-api']['host'] = node['openstack']['endpoints']['host']
default['openstack']['endpoints']['paas-api']['scheme'] = 'http'
default['openstack']['endpoints']['paas-api']['port'] = '9777'
default['openstack']['endpoints']['paas-api']['path'] = ''
default['openstack']['endpoints']['paas-api']['bind_interface'] = nil
