module Lyft
  class Client
    attr_accessor :client_id,
                  :client_secret

    def initialize
      yield self
    end
  end
end
