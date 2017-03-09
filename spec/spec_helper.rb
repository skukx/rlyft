require 'lyft'
require 'pry'
require 'rspec/its'
require 'vcr'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.filter_sensitive_data('<ACCESS_TOKEN>') do |interaction|
    interaction.request.headers['Authorization'].first
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.extend VCR::RSpec::Macros

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.profile_examples = 10

  config.order = :random
  Kernel.srand config.seed
end
