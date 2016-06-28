module Lyft
  module Api
    module Oauth
      def public_token(renew = false)
        return @public_token unless @public_token.nil? && !renew

        uri = Lyft.endpoint('/oauth/token')
        options = {
          body: {
            grant_type: 'client_credentials',
            scope: 'public'
          },
          basic_auth: {
            username: @client_id,
            password: @client_secret
          }
        }
        
        response = HTTParty.post(uri, options).deep_symbolize_keys!
        @public_token = Struct.new(*response.keys).new(*response.values)
      end
    end
  end
end
