require 'spec_helper'

describe Lyft::Client::Configuration do
  let(:use_sandbox) { false }
  let(:client_id) { 'client_id' }
  let(:client_secret) { 'client_secret' }
  let(:options) do
    {
      client_id: client_id,
      client_secret: client_secret,
      use_sandbox: use_sandbox
    }
  end

  let(:config) { Lyft::Client::Configuration.new options }
  subject { config }

  it { is_expected.to respond_to :client_id }
  it { is_expected.to respond_to :client_secret }
  it { is_expected.to respond_to :debug_output }
  it { is_expected.to respond_to :use_sandbox }

  context 'When client_id is blank' do
    let(:client_id) { '' }
    subject { -> { config } }
    
    it { is_expected.to raise_error ArgumentError }
  end

  context 'When client_secret is blank' do
    let(:client_secret) { '' }
    subject { -> { config } }

    it { is_expected.to raise_error ArgumentError }
  end

  describe '#client_secret' do
    subject { config.client_secret }

    context 'When sandboxed' do
      let(:use_sandbox) { true }
      it { is_expected.to start_with('SANDBOX-') }
    end

    context 'When NOT sandboxed' do
      let(:use_sandbox) { false }
      it { is_expected.to_not start_with('SANDBOX-') }
    end
  end

  describe '#sandbox?' do
    subject { config.sandbox? }

    context 'When sandboxed' do
      let(:use_sandbox) { true }
      it { is_expected.to eql true }
    end

    context 'When NOT sandboxed' do
      let(:use_sandbox) { false }
      it { is_expected.to eql false }
    end
  end
end
