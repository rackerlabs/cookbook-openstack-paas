# Encoding: utf-8
require_relative 'spec_helper'

describe 'openstack-paas::setup' do
  describe 'ubuntu' do
    let(:runner) { ChefSpec::Runner.new(::UBUNTU_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) do
      # runner.node.set['logstash'] ...
      runner.node.set[:openstack][:paas][:git][:install_type] = 'git'
      runner.converge(described_recipe)
    end
    include_context 'stubs-common'

    it 'includes db_migrate recipe' do
      expect(chef_run).to include_recipe('openstack-paas::db_migrate')
    end

  end
end
