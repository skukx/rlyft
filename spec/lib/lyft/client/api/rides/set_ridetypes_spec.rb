require 'spec_helper'

describe Lyft::Client::Api::Rides, '#set_ridetypes' do
  let(:request_path) { "/#{Lyft::Client::Api::VERSION}/sandbox/ridetypes" }
  let(:inputs) do
    {
      lat: 37.7772,
      lng: -122.4233,
      ride_types: [
        Lyft::Ride::Type::LYFT,
        Lyft::Ride::Type::LYFT_PLUS
      ]
    }
  end

  let(:config) do
    Lyft::Client::Configuration.new client_id: 'id', client_secret: 'secret', use_sandbox: sandbox
  end

  let(:sandbox) { false }
  let(:instance) { described_class.new config }
  let(:access_token) { 'my_token'}
  let(:ride_id) { '123' }

  subject { instance }

  before :each do
    stub_put(request_path).with(body: inputs, headers: { Authorization: "Bearer #{access_token}" })
  end

  it 'should raise an exception' do
    expect {
      subject.set_ridetypes access_token: access_token, params: inputs
    }.to raise_error RuntimeError
  end

  context 'When in sandbox' do
    let(:sandbox) { true }

    it 'should be successful' do
      resp = subject.set_ridetypes access_token: access_token, params: inputs
      expect(resp.success?).to eql true
    end
  end
end
