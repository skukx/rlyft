require 'spec_helper'

describe Lyft::Client::Api::Base do
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
  let(:client) { Lyft::Client::Api::Base.new config }
  let(:access_token) { 'fake_token' }

  subject { client }
end
