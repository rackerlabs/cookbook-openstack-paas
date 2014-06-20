# Encoding: utf-8

qpid_defaults = {
  username: node[:openstack][:mq][:user],
  sasl_mechanisms: '',
  reconnect: true,
  reconnect_timeout: 0,
  reconnect_limit: 0,
  reconnect_interval_min: 0,
  reconnect_interval_max: 0,
  reconnect_interval: 0,
  heartbeat: 60,
  protocol: node[:openstack][:mq][:qpid][:protocol],
  tcp_nodelay: true,
  host: node[:openstack][:endpoints][:mq][:host],
  port: node[:openstack][:endpoints][:mq][:port],
  qpid_hosts: ["#{node[:openstack][:endpoints][:mq][:host]}:#{node[:openstack][:endpoints][:mq][:port]}"],
  topology_version: node[:openstack][:mq][:qpid][:topology_version]
}

rabbit_defaults = {
  userid: node[:openstack][:mq][:user],
  vhost: node[:openstack][:mq][:vhost],
  port: node[:openstack][:endpoints][:mq][:port],
  host: node[:openstack][:endpoints][:mq][:host],
  ha: false,
  use_ssl: false
}

###################################################################
# Assign default mq attributes for every service
###################################################################
[:paas].each do |svc|
  default[:openstack][:mq][svc][:service_type] = node[:openstack][:mq][:service_type]
  default[:openstack][:mq][svc][:notification_topic] = 'notifications'
  default[:openstack][:mq][svc][:control_exchange] = 'solum'
  default[:openstack][:mq][svc][:durable_queues] =
    node[:openstack][:mq][:durable_queues]
  default[:openstack][:mq][svc][:auto_delete] =
    node[:openstack][:mq][:auto_delete]

  case node[:openstack][:mq][svc][:service_type]
  when 'qpid'
    qpid_defaults.each do |key, val|
      default[:openstack][:mq][svc][:qpid][key.to_s] = val
    end
  when 'rabbitmq'
    rabbit_defaults.each do |key, val|
      default[:openstack][:mq][svc][:rabbit][key.to_s] = val
    end
  end
end
