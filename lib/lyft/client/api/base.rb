module Lyft
  class Client
    module Api
      class Base
        include HTTParty
        base_uri 'https://api.lyft.com'
        parser Lyft::Client::MashedParser

        API_VERSION = ENV['LYFT_API_VERSION'] || 'v1'

        ENDPOINTS = {}
        DEFAULT_VALIDATES = [:access_token]

        ##
        # Constructs path for endpoint.
        #
        # @example Get path for product stock changes.
        #   Products.path_for(:stock_changes) # '/products/stock_changes'
        #
        # @example Get path for product with sku.
        #   Products.path_for(:product, { sku: '123' })
        #   #=> Converts '/products/{{sku}}' to '/products/123'
        #
        # @param [Symbol] key The key for ENDPOINTS.
        # @param [Hash] args A hash which maps values to variables.
        #
        # @return [String] The constructed path.
        #
        def self.path_for(key, args = {})
          # Must call dup because gsub! works with the reference
          # and will change the constant ENDPOINTS which is bad.
          path = self::ENDPOINTS.fetch(key.to_sym).dup
          args.each do |arg_key, value|
            path.gsub!("{{#{arg_key}}}", value.to_s)
          end

          path
        end

        ##
        # Resolve path for ENDPOINTS[key]
        #
        # @example Get path for product stock changes.
        #   client.products.path_for(:stock_changes) # '/products/stock_changes'
        #
        # @example Get path for product with sku.
        #   client.products.path_for(:product, { sku: '123' })
        #   #=> Converts '/products/{{sku}}' to '/products/123'
        #
        # @return [String] The constructed path.
        #
        def path_for(key, args = {})
          self.class.path_for(key, args)
        end

        def initialize(configuration)
          @configuration = configuration
          set_debug_output
        end

        def set_debug_output
          self.class.default_options[:debug_output] = @configuration.debug_output
        end

        protected

        ##
        # Make a request
        #
        # @param [Hash] args
        # @option args [String, Symbol] :http_method The http request method.
        # @option args [String] :endpoint The path to send request to.
        # @option args [String] :access_token The access_token provided by lyft api.
        # @option args [Hash] :options Options for HTTParty
        #
        def make_request(args = {})
          http_method = args.fetch(:http_method)
          endpoint = args.fetch(:endpoint, '')
          access_token = args.fetch(:access_token, '')
          options = args.fetch(:options, {})

          set_authorization_header(access_token)
          self.class.send(http_method, endpoint, options)
        end

        def set_authorization_header(access_token)
          self.class.default_options[:headers] ||= {}
          self.class
              .default_options[:headers]
              .merge! Authorization: "Bearer #{access_token}"
        end
      end
    end
  end
end
