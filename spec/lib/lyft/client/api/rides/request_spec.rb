require 'spec_helper'

describe Lyft::Client::Api::Rides, '#request' do
  let(:request_path) { "/#{Lyft::Client::Api::VERSION}/rides" }
  let(:inputs) do
    {
      origin: { lat: 37.7772, lng: -122.4233 },
      ride_type: Lyft::Ride::Type::LYFT
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
    stub_post(request_path).with(body: inputs, headers: { Authorization: "Bearer #{access_token}" })
  end

  it 'should be successful' do
    resp = subject.request access_token: access_token, params: inputs
    expect(resp.success?).to eql true
  end
end
