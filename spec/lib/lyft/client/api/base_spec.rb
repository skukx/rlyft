require 'spec_helper'

describe Lyft::Client::Api::Base do
  let(:options) do
    {
      client_id: client_id,
      client_secret: client_secret,
      use_sandbox: use_sandbox
    }
  end

  let(:client_id)     { 'client_id' }
  let(:client_secret) { 'client_secret' }
  let(:use_sandbox)   { true }

  let(:config) { Lyft::Client::Configuration.new options }
  let(:instance) { described_class.new config }

  subject { instance }

  its(:configuration) { is_expected.to eql config }

  describe '#connection' do
    context 'When no access_token is passed in' do
      it 'should use basic auth'
    end

    context 'When access_token is passed in' do
      it 'should use authorization header'
    end
  end
end
