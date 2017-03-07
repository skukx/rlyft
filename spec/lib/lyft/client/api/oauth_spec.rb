require 'spec_helper'

describe Lyft::Client::Api::Oauth do
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
  let(:client) { Lyft::Client::Api::Oauth.new config }
  let(:authorization_code) { nil }

  subject { client }

  it { is_expected.to respond_to :retrieve_access_token }

  describe '.headers' do
    subject { described_class.headers }

    it{ is_expected.to include('Content-Type': 'application/json') }
    it { is_expected.to include('Accept': 'application/json') }
  end

  describe '#retrieve_access_token' do
    context 'When authorization_code is nil' do
      let(:expected_body) do
        { grant_type: 'client_credentials', scope: 'public' }
      end

      it 'should have grant_type of client_credentials' do
        expect(described_class).to receive(:post).with('/oauth/token', body: expected_body.to_json)
        client.retrieve_access_token
      end
    end

    context 'When authorization_code is NOT nil' do
      let(:authorization_code) { '123' }
      let(:expected_body) do
        {
          grant_type: 'authorization_code',
          authorization_code: authorization_code
        }
      end

      it 'should have grant_type authorization_code and scope public' do
        expect(described_class).to receive(:post).with('/oauth/token', body: expected_body.to_json)
        client.retrieve_access_token authorization_code: authorization_code
      end
    end
  end
end

describe Lyft::Client::Api::Oauth::ENDPOINTS do
  it { is_expected.to have_key :access_token }
end
