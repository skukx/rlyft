require 'spec_helper'

describe Lyft::Client::Api::Availability, '#eta' do
  let(:request_path) { "/#{Lyft::Client::Api::VERSION}/eta" }
  let(:inputs) do
    {
      lat: 37.7772,
      lng: -122.4233
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
    resp = subject.eta access_token: access_token, params: inputs
    expect(resp.success?).to eql true
  end
end
