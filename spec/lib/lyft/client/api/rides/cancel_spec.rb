require 'spec_helper'

describe Lyft::Client::Api::Rides, '#cancel' do
  let(:request_path) { "/#{Lyft::Client::Api::VERSION}/rides/#{ride_id}/cancel" }
  let(:inputs) do
    {
      confirmation_token: 'abc123'
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
    resp = subject.cancel access_token: access_token, params: inputs.merge(ride_id: ride_id)
    expect(resp.success?).to eql true
  end
end
