require 'spec_helper'

describe Lyft::Client do
  let(:options) do
    {
      client_id: 'client_id',
      client_secret: 'client_secret',
      use_sandbox: true
    }
  end

  let(:client) { Lyft::Client.new options }
  subject { client }

  it { is_expected.to respond_to :oauth }
  it { is_expected.to respond_to :availability }
  it { is_expected.to respond_to :rides }
  it { is_expected.to respond_to :user }

  describe '#oauth' do
    subject { client.oauth }
    it { is_expected.to be_kind_of Lyft::Client::Api::Oauth }
  end

  describe '#availability' do
    subject { client.availability }
    it { is_expected.to be_kind_of Lyft::Client::Api::Availability }
  end

  describe '#rides' do
    subject { client.rides }
    it { is_expected.to be_kind_of Lyft::Client::Api::Rides }
  end

  describe '#user' do
    subject { client.user }
    it { is_expected.to be_kind_of Lyft::Client::Api::User }
  end
end
