module Lyft
  class Client
    module Api
      class Base
        attr_reader :configuration

        def initialize(configuration)
          @configuration = configuration
        end

        def connection(access_token = nil)
          Faraday.new(url: BASE_URL) do |conn|
            # Headers
            conn.headers = configuration.headers

            if access_token
              conn.authorization :Bearer, access_token
            else
              conn.basic_auth(
                configuration.client_id,
                configuration.client_secret
              )
            end

            # Request
            conn.request :json

            # Response
            conn.response :json
            conn.response :logger

            conn.adapter  Faraday.default_adapter
          end
        end

        protected

        def handle_response(response)
          # Wrap in our own response class
          Lyft::Response.new response
        end
      end
    end
  end
end
