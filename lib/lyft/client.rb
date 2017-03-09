module Lyft
  ##
  # Client for making Lyft api requests
  #
  class Client
    ##
    # Keep track of what we are namespacing.
    #
    @@namespaces = []

    attr_reader :configuration

    ##
    # Defines a method to access class instance.
    #
    # @example Create a namespace for availability
    #   namespace :availability #=> Lyft::Client::Availability.new
    #
    def self.namespace(name)
      converted = name.to_s.split('_').map(&:capitalize).join
      klass = Lyft::Client::Api.const_get(converted)
      create_instance(klass)
    end

    ##
    # Dynamically creates an attr_reader for each client space
    # and sets it to the initalized values
    #
    def self.create_instance(klass)
      reader = klass.to_s.split('::').last.underscore
      @@namespaces << reader

      define_method(reader.to_sym) { klass.new @@config }
    end

    ##
    # Class to handle availability api calls.
    # @return Lyft::Client::Api::Oauth
    #
    namespace :oauth

    ##
    # Class to handle availability api calls.
    # @return Lyft::Client::Api::Availability
    #
    namespace :availability

    ##
    # Class to handle availability api calls.
    # @return Lyft::Client::Api::Rides
    #
    namespace :rides

    ##
    # Class to handle availability api calls.
    # @return Lyft::Client::Api::User
    #
    namespace :user

    ##
    # The initializer
    #
    # @param [Hash] args
    # @option args [String] :client_id
    # @option args [String] :client_secret
    # @option args [Boolean] :debug_output
    #
    def initialize(args = {})
      @configuration = Lyft::Client::Configuration.new args
      @@config = @configuration
    end
  end
end
