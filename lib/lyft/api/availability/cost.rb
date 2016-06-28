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
            start_lat: args[:start_lat] || 37.7772,
            start_lng: args[:start_lng] || -122.4233,
            end_lat: args[:end_lat] || 37.7972,
            end_lng: args[:end_lng] || -122.4533
          }
        }

        HTTParty.get(uri, options)
      end
    end
  end
end
