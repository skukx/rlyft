module Lyft
  module Api
    module Availability
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
