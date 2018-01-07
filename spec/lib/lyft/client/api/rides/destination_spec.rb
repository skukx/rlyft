require 'spec_helper'

describe Lyft::Client::Api::Rides, '#destination' do
  let(:request_path) { "/#{Lyft::Client::Api::VERSION}/rides/#{ride_id}/destination" }
  let(:inputs) do
    {
      lat: 37.7772,
      lng: -122.4233,
      address: '123 Fake St'
    }
  end

  let(:config) do
    Lyft::Client::Configuration.new client_id: 'id', client_secret: 'secret'
  end

  let(:instance) { described_class.new config }
  let(:access_token) { 'my_token'}
  let(:ride_id) { '123' }

  subject { instance }

  before :each do
    stub_put(request_path).with(body: inputs, headers: { Authorization: "Bearer #{access_token}" })
  end

  it 'should be successful' do
    resp = subject.destination access_token: access_token, params: inputs.merge(ride_id: ride_id)
    expect(resp.success?).to eql true
  end
end
