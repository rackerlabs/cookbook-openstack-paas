# Encoding: utf-8
require_relative 'spec_helper'

describe 'openstack-paas::_client_git' do
  describe 'ubuntu' do
    let(:runner) { ChefSpec::Runner.new(::UBUNTU_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) do
      # runner.node.set['logstash'] ...
      runner.node.set[:openstack][:paas][:platform][:prereq_packages] = ['libffi-dev']
      runner.node.set[:openstack][:paas][:user] = 'solum'
      runner.node.set[:openstack][:paas][:client][:git][:install_dir] = '/opt/solumclient'
      runner.node.set[:openstack][:paas][:client][:git][:repository] = 'https://github.com/stackforge/python-solumclient.git'
      runner.node.set[:openstack][:paas][:client][:git][:revision] = 'master'
      runner.converge(described_recipe)
    end
    include_context 'stubs-common'

    it 'includes necessary recipes' do
      expect(chef_run).to include_recipe('git::default')
      expect(chef_run).to include_recipe('python::default')
      expect(chef_run).to include_recipe('build-essential::default')
    end

    it 'installs pre-req packages' do
      expect(chef_run).to upgrade_package('libffi-dev')
    end

    it 'creates solum user' do
      expect(chef_run).to create_user('solum')
    end

    it 'creates solumclient home dir' do
      expect(chef_run).to create_directory('/opt/solumclient')
    end

    it 'clones solumclient git repo' do
      expect(chef_run).to sync_git('/opt/solumclient').with(
        repository: 'https://github.com/stackforge/python-solumclient.git',
        revision: 'master',
        destination: '/opt/solumclient'
      )
    end

    it 'installs solumclient via pip' do
      expect(chef_run).to install_python_pip('/opt/solumclient')
    end

  end
end
