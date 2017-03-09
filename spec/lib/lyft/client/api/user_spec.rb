require 'spec_helper'

describe Lyft::Client::Api::User do
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
  let(:client) { Lyft::Client::Api::User.new config }
  let(:access_token) { 'SANDBOX-gAAAAABYwM9axZZNIoQZBwolK4HSaT_S9CEwYkMSY_W8vh9-PkKotGEV8ZJLoliCZwcD4C_wd-JRe3FOY7Fdpuu_sZVWoDFGAuqX-zX7m01oLZBEHPAe5upRewawpYIVlCCpL9q-CHc0p8EAd7py4NnIAbokLKsziH-WRTA3m5b5HWa20kCzGSX64Rsj4JdGj231gr_QWQF1bKT9qVPS7PZvNXEg2CQNY_AklIBQ39DWYCxabY-lEar_SLA2ZNWRfQuhXObUaoxnp8F7hZBr9DeDKY37u-SxXBuLiT0VRqQMjwmf4q8nXN2sZB_lTbhcXgErVv8ZmjSRFMioupWgD0xGRLCzxFPvsg==' }

  subject { client }

  its(:class) { is_expected.to be_const_defined :ENDPOINTS }

  describe '#ride_history' do
    use_vcr_cassette

    let(:start_time) { '2015-12-01T21:04:22Z' }
    let(:args) do
      {
        start_time: start_time,
        access_token: access_token
      }
    end
    subject { client.ride_history(args) }

    it { is_expected.to be_kind_of HTTParty::Response }
    it { expect(subject.success?).to eql true }
  end

  describe '#profile' do
    use_vcr_cassette

    let(:args) do
      {
        access_token: access_token
      }
    end
    subject { client.profile(args) }

    it { is_expected.to be_kind_of HTTParty::Response }
    it { expect(subject.success?).to eql true }
  end
end
