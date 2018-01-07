module Lyft
  class Client
    module Api
      ##
      # Client for making authentication related requests to the
      # lyft api
      #
      class Oauth < Lyft::Client::Api::Base
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
        # @param [String] scope
        # @return [HTTParty::Response]
        #
        def retrieve_access_token(authorization_code: nil, scope: Scope::PUBLIC)
          body = build_auth_body(authorization_code, scope)
          resp = connection.post '/oauth/token', body
          handle_response(resp)
        end

        private

        def build_auth_body(authorization_code, scope)
          body = {}
          body[:grant_type] = grant_type(authorization_code)
          if authorization_code.present?
            body[:code] = authorization_code
          else
            body[:scope] = scope
          end

          body
        end

        def grant_type(authorization_code)
          return GrantType::AUTHORIZATION_CODE if authorization_code
          GrantType::CLIENT_CREDENTIALS
        end
      end
    end
  end
end
