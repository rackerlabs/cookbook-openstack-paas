# Encoding: utf-8

require_relative 'spec_helper'

describe 'solum::default' do
  describe 'ubuntu' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  end
end
