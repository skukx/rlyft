module Lyft
  ##
  # Client for making Lyft api requests
  #
  # @attr [String] client_id The client id for lyft app.
  # @attr [String] client_secret The client secret for lyft app.
  #
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
