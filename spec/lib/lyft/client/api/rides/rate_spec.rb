require 'spec_helper'

describe Lyft::Client::Api::Rides, '#rate' do
  let(:request_path) { "/#{Lyft::Client::Api::VERSION}/rides/#{ride_id}/rating" }
  let(:inputs) do
    {
      rating: 5,
      tip: {
        amount: 100,
        currency: 'USD'
      },
      feedback: 'Nice Driving!'
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
    resp = subject.rate access_token: access_token, params: inputs.merge(ride_id: ride_id)
    expect(resp.success?).to eql true
  end
end
