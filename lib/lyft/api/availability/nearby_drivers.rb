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
            lat: args[:lat] || 37.7772,
            lng: args[:lng] || -122.4233
          }
        }

        HTTParty.get(uri, options)
      end
    end
  end
end
