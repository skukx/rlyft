module Lyft
  module Api
    module Availability
      ##
      # Get eta for lyft driver to reach location
      #
      # @example
      #     client.eta lat: 37.7772,
      #                lng: -122.4233
      #
      # @param [Hash] args
      # @option args [Float] :lat The latitude of pickup. (*required*)
      # @option args [Float] :lng The longitude of pickup. (*required*)
      def eta(args = {})
        uri = Lyft.endpoint('/v1/eta')
        options = {
          headers: {
            Authorization: "Bearer #{public_token.access_token}"
          }.as_json,
          query: {
            lat: args.fetch(:lat),
            lng: args.fetch(:lng)
          }
        }

        HTTParty.get(uri, options)
      end
    end
  end
end
