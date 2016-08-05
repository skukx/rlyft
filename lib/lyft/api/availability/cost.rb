module Lyft
  module Api
    module Availability
      ##
      # Get Lyft costs
      #
      # @example
      #     client.cost start_lat: 37.7772,
      #                 start_lng: -122.4233,
      #                 end_lat: 37.7972,
      #                 end_lng: -122.4533
      #
      # @param [Hash] args
      # @option args [Float] :start_lat The latitude of starting point. (*required*)
      # @option args [Float] :start_lng The longitude of starting point. (*required*)
      # @option args [Float] :end_lat The latitude of the end point. (*required*)
      # @option args [Float] :end_lng The longitude of the end point. (*required*)
      def cost(args = {})
        uri = Lyft.endpoint('/v1/cost')
        options = {
          headers: {
            Authorization: "Bearer #{public_token.access_token}"
          }.as_json,
          query: {
            start_lat: args.fetch(:start_lat),
            start_lng: args.fetch(:start_lng),
            end_lat: args.fetch(:end_lat),
            end_lng: args.fetch(:end_lng)
          }
        }

        HTTParty.get(uri, options)
      end
    end
  end
end
