require 'spec_helper'

describe Lyft::Client do
  let(:options) do
    {
      client_id: 'client_id',
      client_secret: 'client_secret',
      use_sandbox: true
    }
  end

  let(:instance) { Lyft::Client.new options }
  subject { instance }

  it { is_expected.to respond_to :oauth }
  it { is_expected.to respond_to :availability }
  it { is_expected.to respond_to :rides }
  it { is_expected.to respond_to :user }

  describe '#oauth' do
    subject { instance.oauth }
    it { is_expected.to be_kind_of Lyft::Client::Api::Oauth }
  end

  describe '#availability' do
    subject { instance.availability }
    it { is_expected.to be_kind_of Lyft::Client::Api::Availability }
  end

  describe '#rides' do
    subject { instance.rides }
    it { is_expected.to be_kind_of Lyft::Client::Api::Rides }
  end

  describe '#user' do
    subject { instance.user }
    it { is_expected.to be_kind_of Lyft::Client::Api::User }
  end
end
