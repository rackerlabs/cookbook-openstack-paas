# Encoding: utf-8
require_relative 'spec_helper'

describe 'openstack-paas::db_migrate' do
  describe 'ubuntu' do
    let(:runner) { ChefSpec::Runner.new(::UBUNTU_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) do
      # runner.node.set['logstash'] ...
      runner.node.set[:openstack][:paas][:git][:install_type] = 'git'
      runner.converge(described_recipe)
    end
    include_context 'stubs-common'

    it 'runs db_migrate' do
      expect(chef_run).to run_execute('solum-db-manage --config-file=/etc/solum/solum.conf upgrade head')
    end

  end
end
