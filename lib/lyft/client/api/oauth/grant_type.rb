module Lyft
  class Client
    module Api
      class Oauth < Lyft::Client::Api::Base
        class GrantType
          AUTHORIZATION_CODE = 'authorization_code'
          CLIENT_CREDENTIALS = 'client_credentials'
        end
      end
    end
  end
end
