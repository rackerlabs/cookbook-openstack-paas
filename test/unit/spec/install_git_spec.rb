# Encoding: utf-8
require_relative 'spec_helper'

describe 'openstack-paas::_install_git' do
  describe 'ubuntu' do
    let(:runner) { ChefSpec::Runner.new(::UBUNTU_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) do
      # runner.node.set['logstash'] ...
      runner.node.set[:openstack][:paas][:platform][:prereq_packages] = ['libffi-dev']
      runner.node.set[:openstack][:paas][:user] = 'solum'
      runner.node.set[:openstack][:paas][:group] = 'solum'
      runner.node.set[:openstack][:paas][:git][:install_dir] = '/opt/solum'
      runner.node.set[:openstack][:paas][:git][:repository] = 'https://github.com/stackforge/solum.git'
      runner.node.set[:openstack][:paas][:git][:revision] = 'master'
      runner.node.set[:openstack][:paas][:config][:keystone_authtoken][:signing_dir] = '/var/cache/solum'
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

    it 'creates solum keystone signing directory' do
      expect(chef_run).to create_directory('/var/cache/solum').with(
        mode: '0700',
        user: 'solum',
        group: 'solum'
      )
    end

    it 'installs solum via pip' do
      expect(chef_run).to install_python_pip('/opt/solum')
    end

    it 'creates etsy solum directory' do
      expect(chef_run).to create_directory('/etc/solum')
    end

  end
end
