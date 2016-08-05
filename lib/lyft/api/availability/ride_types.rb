module Lyft
  module Api
    module Availability
      ##
      # Get available lyft ride types
      #
      # @example
      #     client.ride_types lat: 37.7772,
      #                       lng: -122.4233
      #
      # @param [Hash] args
      # @option args [Float] :lat The latitude of pickup. (*required*)
      # @option args [Float] :lng The longitude of pickup. (*required*)
      def ride_types(args = {})
        uri = Lyft.endpoint('/v1/ridetypes')
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
