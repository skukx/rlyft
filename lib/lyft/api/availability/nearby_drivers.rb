module Lyft
  module Api
    module Availability
      def nearby_drivers(args = {})
        uri = Lyft.endpoint('/v1/drivers')
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
