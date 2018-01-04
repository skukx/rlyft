require 'spec_helper'

def request_ride(client, access_token)
  client.request(
    origin: {
      lat: 37.7772,
      lng: -122.4233
    },
    destination: {
      lat: 37.7972,
      lng: -122.4533
    },
    ride_type: Lyft::Ride::Type::LYFT,
    access_token: access_token
  )
end

describe Lyft::Client::Api::Rides do
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
  let(:client) { Lyft::Client::Api::Rides.new config }
  let(:access_token) { 'fake_token' }

  subject { client }

  its(:class) { is_expected.to be_const_defined :ENDPOINTS }

  describe '#request', :vcr do
    let(:args) do
      {
        origin: {
          lat: 37.7772,
          lng: -122.4233
        },
        destination: {
          lat: 37.7972,
          lng: -122.4533
        },
        ride_type: Lyft::Ride::Type::LYFT,
        access_token: access_token
      }
    end
    subject { client.request(args) }

    it { is_expected.to be_kind_of HTTParty::Response }
    it { expect(subject.success?).to eql true }
  end

  context 'When ride id obtained' do
    let(:ride_id) { request_ride(client, access_token).ride_id }

    describe '#destination', :vcr do
      let(:args) do
        {
          lat: 37.7972,
          lng: -122.4533,
          ride_id: ride_id,
          access_token: access_token
        }
      end
      subject { client.destination(args) }

      it { is_expected.to be_kind_of HTTParty::Response }
      it { expect(subject.success?).to eql true }
    end

    describe '#cancel', :vcr do
      let(:args) do
        {
          ride_id: ride_id,
          access_token: access_token
        }
      end
      subject { client.cancel(args) }

      it { is_expected.to be_kind_of HTTParty::Response }
      it { expect(subject.success?).to eql true }
    end

    describe '#details', :vcr do
      let(:args) do
        {
          ride_id: ride_id,
          access_token: access_token
        }
      end
      subject { client.details(args) }

      it { is_expected.to be_kind_of HTTParty::Response }
      it { expect(subject.success?).to eql true }
    end

    context 'When dropped off', :vcr do
      before do
        flow = [
          Lyft::Ride::Status::ACCEPTED,
          Lyft::Ride::Status::ARRIVED,
          Lyft::Ride::Status::PICKED_UP,
          Lyft::Ride::Status::DROPPED_OFF
        ]

        flow.each do |status|
          client.set_status access_token: access_token,
                            ride_id: ride_id,
                            status: status
        end
      end

      describe '#rate', :vcr do
        let(:args) do
          {
            ride_id: ride_id,
            rating: 5,
            tip: {
              amount: 10.00,
              currency: 'USD'
            },
            access_token: access_token
          }
        end
        subject { client.rate(args) }

        it { is_expected.to be_kind_of HTTParty::Response }
        it { expect(subject.success?).to eql true }
      end

      describe '#receipt', :vcr do
        let(:args) do
          {
            ride_id: ride_id,
            access_token: access_token
          }
        end
        subject { client.receipt(args) }

        it { is_expected.to be_kind_of HTTParty::Response }
        it { expect(subject.success?).to eql true }
      end
    end
  end
end
