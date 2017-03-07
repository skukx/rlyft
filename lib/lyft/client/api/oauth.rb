module Lyft
  class Client
    module Api
      ##
      # Client for making authentication related requests to the
      # lyft api
      #
      class Oauth < Lyft::Client::Api::Base
        ##
        # Authentication Endpoints
        #
        ENDPOINTS = {
          access_token: '/oauth/token'
        }

        headers 'Content-Type': 'application/json',
                'Accept': 'application/json'

        def initialize(config)
          super
          set_default_headers
        end

        ##
        # Retrieves access token from the server.
        #
        # @example Get public access token.
        #   resp = client.authentication.retrieve_access_token
        #   resp.success?
        #
        # @example Get access token from authorization_code.
        #   resp = client.authentication.retrieve_access_token authorization_code: 'auth_code'
        #   resp.success?
        #
        # @param [String] authorization_code
        # @return [HTTParty::Response]
        #
        def retrieve_access_token(authorization_code: nil)
          path = path_for(:access_token)

          grant_type = get_grant_type(authorization_code.present?)
          body = request_body(
            grant_type: grant_type,
            authorization_code: authorization_code
          )

          self.class.post(path, body: body.to_json)
        end

        private

        def get_grant_type(has_auth_code)
          return 'authorization_code' if has_auth_code
          'client_credentials'
        end

        def request_body(grant_type:, authorization_code:, scope: 'public')
          body = {}
          body[:grant_type] = grant_type
          body[:scope] = scope unless authorization_code.present?
          body[:code] = authorization_code if authorization_code.present?

          body
        end

        def set_default_headers
          self.class.default_options[:headers].delete(:Authorization)
          self.class.basic_auth @configuration.client_id, @configuration.client_secret
        end
      end
    end
  end
end
