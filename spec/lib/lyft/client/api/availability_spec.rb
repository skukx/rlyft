require 'spec_helper'

describe Lyft::Client::Api::Availability do
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
  let(:client) { Lyft::Client::Api::Availability.new config }
  let(:access_token) { 'fake_token' }

  subject { client }

  its(:class) { is_expected.to be_const_defined :ENDPOINTS }

  describe '#cost', :vcr do
    let(:args) do
      {
        start_lat: 37.7772,
        start_lng: -122.4233,
        end_lat: 37.7972,
        end_lng: -122.4533,
        access_token: access_token
      }
    end
    subject { client.cost(args) }

    it { is_expected.to be_kind_of HTTParty::Response }
    it { expect(subject.success?).to eql true }
  end

  describe '#eta', :vcr do
    let(:args) do
      {
        lat: 37.7772,
        lng: -122.4233,
        access_token: access_token
      }
    end
    subject { client.eta(args) }

    it { is_expected.to be_kind_of HTTParty::Response }
    it { expect(subject.success?).to eql true }
  end

  describe '#nearby_drivers', :vcr do
    let(:args) do
      {
        lat: 37.7772,
        lng: -122.4233,
        access_token: access_token
      }
    end
    subject { client.nearby_drivers(args) }

    it { is_expected.to be_kind_of HTTParty::Response }
    it { expect(subject.success?).to eql true }
  end

  describe '#ride_types', :vcr do
    let(:args) do
      {
        lat: 37.7772,
        lng: -122.4233,
        access_token: access_token
      }
    end
    subject { client.ride_types(args) }

    it { is_expected.to be_kind_of HTTParty::Response }
    it { expect(subject.success?).to eql true }
  end
end

describe Lyft::Client::Api::Availability::ENDPOINTS do
  it { is_expected.to be_key :cost }
  it { is_expected.to be_key :eta }
  it { is_expected.to be_key :nearby_drivers }
  it { is_expected.to be_key :ride_types }
end
