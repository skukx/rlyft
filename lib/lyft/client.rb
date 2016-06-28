module Lyft
  class Client
    include Api::Oauth
    include Api::Availability
    include Api::Rides
    include Api::Users

    attr_accessor :client_id,
                  :client_secret

    def initialize
      yield self
    end
  end
end
