# 3rd party Libraries
require 'httparty'
require 'active_support/all'

# Gem libraries
Dir[File.dirname(__FILE__) + '/lyft/**/*.rb'].each { |file| require file }

module Lyft
  API_URI = 'https://api.lyft.com'

  def self.endpoint(path)
    API_URI + path
  end
end
