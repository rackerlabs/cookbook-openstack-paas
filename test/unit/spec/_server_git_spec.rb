# Encoding: utf-8
require_relative 'spec_helper'

describe 'openstack-paas::_server_git' do
  describe 'ubuntu' do
    let(:runner) { ChefSpec::Runner.new(::UBUNTU_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) do
      # runner.node.set['logstash'] ...
      runner.node.set[:openstack][:paas][:platform][:prereq_packages] = ['libffi-dev']
      runner.node.set[:openstack][:paas][:user] = 'solum'
      runner.node.set[:openstack][:paas][:git][:install_dir] = '/opt/solum'
      runner.node.set[:openstack][:paas][:git][:repository] = 'https://github.com/stackforge/solum.git'
      runner.node.set[:openstack][:paas][:git][:revision] = 'master'
      runner.converge(described_recipe)
    end
    include_context 'stubs-common'

    it 'includes necessary recipes' do
      expect(chef_run).to include_recipe('git::default')
      expect(chef_run).to include_recipe('python::default')
      expect(chef_run).to include_recipe('build-essential::default')
      expect(chef_run).to include_recipe('runit::default')
    end

    it 'installs pre-req packages' do
      expect(chef_run).to upgrade_package('libffi-dev')
    end

    it 'creates solum user' do
      expect(chef_run).to create_user('solum')
    end

    it 'creates solum home dir' do
      expect(chef_run).to create_directory('/opt/solum')
    end

    it 'clones solum git repo' do
      expect(chef_run).to sync_git('/opt/solum').with(
        repository: 'https://github.com/stackforge/solum.git',
        revision: 'master',
        destination: '/opt/solum'
      )
    end

    it 'installs solum via pip' do
      expect(chef_run).to install_python_pip('/opt/solum')
    end

    it 'creates etsy solum directory' do
      expect(chef_run).to create_directory('/etc/solum')
    end

    it 'creates runit service for solum-api' do
      skip 'LWRP matcher not available until runit cookbook 1.5.11'
      # expect(chef_run).to enable_runit_service('solum-api')
    end

  end
end
