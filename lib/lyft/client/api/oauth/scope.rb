module Lyft
  class Client
    module Api
      class Oauth < Lyft::Client::Api::Base
        ##
        # @see https://developer.lyft.com/v1/docs/authentication#section-scopes
        #
        class Scope
          PUBLIC = 'public'
          READ_RIDES = 'rides.read'
          OFFLINE = 'offline'
          REQUEST_RIDES = 'rides.request'
          PROFILE = 'profile'
        end
      end
    end
  end
end
