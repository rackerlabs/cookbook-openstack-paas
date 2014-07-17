# Encoding: utf-8
require_relative 'spec_helper'

describe 'openstack-paas::install' do
  describe 'ubuntu' do
    let(:runner) { ChefSpec::Runner.new(::UBUNTU_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) do
      # runner.node.set['logstash'] ...
      runner.node.set[:openstack][:paas][:git][:install_type] = 'git'
      runner.converge(described_recipe)
    end
    include_context 'stubs-common'

    it 'installs mysql packages' do
      expect(chef_run).to upgrade_package('python-mysqldb')
    end

    it 'installs solum via git' do
      expect(chef_run).to include_recipe('openstack-paas::_install_git')
    end

    it 'lays down solum config file' do
      expect(chef_run).to create_template('/etc/solum/solum.conf')
    end

  end
end
