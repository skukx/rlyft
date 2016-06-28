module Lyft
  module Api
    module Availability
      def ride_types(args = {})
        uri = Lyft.endpoint('/v1/ridetypes')
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
