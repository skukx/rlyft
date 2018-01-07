module Lyft
  ##
  # Client for making Lyft api requests
  #
  class Client
    ##
    # The configuration for the Lyft Client
    # @return [Lyft::Api::Configuration]
    #
    attr_reader :configuration

    ##
    # Keep track of what we are namespacing.
    #
    @namespaces = []
    @connection = nil

    ##
    # Defines a method to access class instance.
    #
    # @example Create a namespace for availability
    #   namespace :availability #=> Lyft::Client::Availability.new
    #
    def self.namespace(name)
      converted = name.to_s.split('_').map(&:capitalize).join
      klass = Lyft::Client::Api.const_get(converted)
      @namespaces << klass
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
      build_namespaces
    end

    private

    def build_namespaces
      namespaces = self.class.instance_variable_get(:@namespaces)
      namespaces.each do |klass|
        reader = klass.to_s.split('::').last.underscore
        self.class.send(:define_method, reader.to_sym) { klass.new @configuration }
      end
    end
  end
end
