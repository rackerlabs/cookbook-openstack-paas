# Encoding: utf-8
require_relative 'spec_helper'

describe 'openstack-paas::client' do
  describe 'ubuntu' do
    let(:runner) { ChefSpec::Runner.new(::UBUNTU_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) do
      # runner.node.set['logstash'] ...
      runner.node.set[:openstack][:paas][:syslog][:use] = true
      runner.node.set[:openstack][:db][:paas][:service_type] = 'mysql'
      runner.node.set[:openstack][:paas][:git][:install_type] = 'git'
      runner.node.set[:openstack][:db][:paas][:migrate] = true
      runner.converge(described_recipe)
    end
    include_context 'stubs-common'

    it 'installs solumclient via git' do
      expect(chef_run).to include_recipe('openstack-paas::_client_git')
    end

  end
end
