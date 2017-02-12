module Lyft
  class Client
    class Configuration
      attr_reader :client_id, :client_secret, :debug_output

      def initialize(args = {})
        raise ArgumentError, ':client_id is missing' if args[:client_id].blank?
        raise ArugmentError, ':client_secret is missing' if args[:client_secret].blank?

        @client_id = args[:client_id]
        @client_secret = args[:client_secret]
        @debug_output = args[:debug_output]
      end
    end
  end
end
