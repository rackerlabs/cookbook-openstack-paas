# Encoding: utf-8
name             'openstack-paas'
maintainer       'Paul Czarkowski - Rackspace'
maintainer_email 'paul.czarkowski@rackspace.com'
license          'Apache2'
description      'Installs/Configures Openstack Solum'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.3.2'

%w(apt git python build-essential runit libarchive).each do |dep|
  depends dep
end

depends 'openstack-common', '~> 9.4'
depends 'openstack-identity', '~> 9.0'
