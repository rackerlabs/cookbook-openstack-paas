Description
===========

This cookbook installs the OpenStack PAAS (CI/CD) Service **Solum** as part of the OpenStack reference deployment Chef for OpenStack. The http://github.com/stackforge/chef-openstack-repo contains documentation for using this cookbook in the context of a full OpenStack deployment. Keystone is installed from packages, creating the default user, tenant, and roles. It also registers the identity service and identity endpoint.

https://wiki.openstack.org/wiki/Solum

Requirements
============

Chef 0.11.0 or higher required (for Chef environment use)

Usage
=====

client
------

Installs and configures Solum client packages

server
------

Installs and configures Solum Services

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[openstack-paas::server]"
  ]
}
```

Attributes
==========

to be documented

Testing
=====

Please refer to the [TESTING.md](TESTING.md) for instructions for testing the cookbook.

Berkshelf
=====

Berks will resolve version requirements and dependencies on first run and
store these in Berksfile.lock. If new cookbooks become available you can run
`berks update` to update the references in Berksfile.lock. Berksfile.lock will
be included in stable branches to provide a known good set of dependencies.
Berksfile.lock will not be included in development branches to encourage
development against the latest cookbooks.

License and Author
==================

Author:: Paul Czarkowski (<paul.czarkowski@rackspace.com>)

Copyright 2014, Rackspace US, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
