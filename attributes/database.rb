# Encoding: utf-8

default[:openstack][:db][:paas][:service_type] = node[:openstack][:db][:service_type]
default[:openstack][:db][:paas][:host] = node[:openstack][:endpoints][:db][:host]
default[:openstack][:db][:paas][:port] = node[:openstack][:endpoints][:db][:port]
default[:openstack][:db][:paas][:db_name] = 'solum'
default[:openstack][:db][:paas][:username] = 'solum'
default[:openstack][:db][:paas][:options] = node[:openstack][:db][:options]
default[:openstack][:db][:paas][:migrate] = true
