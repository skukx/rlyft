require 'spec_helper'

describe Lyft::Client::Api::Availability, '#cost' do
  let(:request_path) { "/#{Lyft::Client::Api::VERSION}/cost" }
  let(:inputs) do
    {
      start_lat: 37.7772,
      start_lng: -122.4233,
      end_lat: 37.7972,
      end_lng: -122.4533
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
    stub_get(request_path).with(query: inputs, headers: { Authorization: "Bearer #{access_token}" })
  end

  it 'should be successful' do
    resp = subject.cost access_token: access_token, params: inputs
    expect(resp.success?).to eql true
  end
end
