module Lyft
  class Client
    class Configuration
      attr_reader :client_id, :client_secret, :debug_output, :use_sandbox

      def initialize(args = {})
        raise ArgumentError, ':client_id is missing' if args[:client_id].blank?
        raise ArgumentError, ':client_secret is missing' if args[:client_secret].blank?

        @client_id = args.fetch(:client_id)
        @client_secret = args.fetch(:client_secret)
        @use_sandbox = args.fetch(:use_sandbox, false)
        @debug_output = args[:debug_output]

        @client_secret = "SANDBOX-#{@client_secret}" if sandbox?
      end

      def sandbox?
        @use_sandbox
      end
    end
  end
end
