# Encoding: utf-8
require_relative 'spec_helper'

describe 'openstack-paas::paas_api' do
  describe 'ubuntu' do
    let(:runner) { ChefSpec::Runner.new(::UBUNTU_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) do
      runner.converge(described_recipe)
    end
    include_context 'stubs-common'

    it 'includes necessary recipes' do
      expect(chef_run).to include_recipe('runit::default')
    end

    it 'creates runit service for solum-api' do
      skip 'LWRP matcher not available until runit cookbook 1.5.11'
      # expect(chef_run).to enable_runit_service('solum-api')
    end

  end
end
