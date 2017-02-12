module Lyft
  class Client
    module Api
      class Rides < Lyft::Client::Api::Base
        headers 'Content-Type': 'application/json'

        ENDPOINTS = {
          request: '/v1/rides',
          details: '/v1/rides/{{ride_id}}',
          cancel: '/v1/rides/{{ride_id}}/cancel',
          rating: '/v1/rides/{{ride_id}}/rating',
          receipt: 'v1/rides/{{ride_id}}/receipt',
          destination: '/v1/rides/{{ride_id}}/destination'
        }

        ##
        # Cancel a ride request.
        # @see https://developer.lyft.com/docs/request-cancel
        #
        # @param [Hash] args
        # @option args [String] :access_token (*required*)
        # @option args [String] :ride_id (*required*)
        # @option args [String] :cancel_confirmation_token
        #
        def cancel(args = {})
          make_request(
            http_method: :post,
            endpoint: path_for(:cancel, ride_id: args.delete(:ride_id)),
            access_token: args.delete(:access_token),
            options: { body: args.to_json }
          )
        end

        ##
        # Update the ride destination
        # @see https://developer.lyft.com/docs/request-destination
        #
        # @param [Hash] args
        # @option args [String] :access_token (*required*)
        # @option args [String] :ride_id (*required*)
        # @option args [Float] :lat (*required*)
        # @option args [Float] :lng (*required*)
        # @option args [String] :address
        #
        def destination(args = {})
          make_request(
            http_method: :put,
            endpoint: path_for(:destination, ride_id: args.delete(:ride_id)),
            access_token: args.delete(:access_token),
            options: { body: args.to_json }
          )
        end

        ##
        # Get details of a ride.
        # @see https://developer.lyft.com/docs/ride-request-details
        #
        # @param [Hash] args
        # @option args [String] :access_token (*required*)
        # @option args [String] :ride_id The ride id. (*required*)
        #
        def details(args = {})
          make_request(
            http_method: :get,
            endpoint: path_for(:details, ride_id: args.delete(:ride_id)),
            access_token: args.delete(:access_token)
          )
        end

        ##
        # Rate a ride and/or provide a tip.
        # @see https://developer.lyft.com/docs/ride-request-rating-and-tipping
        #
        # @param [Hash] args
        # @option args [String] :access_token (*required*)
        # @option args [String] :ride_id (*required*)
        # @option args [Integer] :rating Rating should be between 1 and 5 inclusive. (*required*)
        # @option args [Hash] :tip The tip should include :amount and :currency.
        # @option args [String] :feedback
        #
        def rate(args = {})
          make_request(
            http_method: :put,
            endpoint: path_for(:rating, ride_id: args.delete(:ride_id)),
            access_token: args.delete(:access_token),
            options: { body: args.to_json }
          )
        end

        ##
        # Get receipt for ride
        # @see https://developer.lyft.com/docs/request-receipt
        #
        # @param [Hash] args
        # @option args [String] :access_token (*required*)
        # @option args [String] :ride_id (*required*)
        #
        def receipt(args = {})
          make_request(
            http_method: :get,
            endpoint: path_for(:receipt, ride_id: args.delete(:ride_id)),
            access_token: args.delete(:access_token)
          )
        end

        ##
        # Request a ride.
        # @see https://developer.lyft.com/docs/request
        #
        # @param [Hash] args
        # @option args [String] :access_token (*required*)
        # @option args [Hash] :origin The origin should contain :lat and :lng
        # @option args [Hash] :destination The destination should contain :lat and :lng.
        # @option args [String] :ride_type
        # @option args [String] :primetime_confirmation_token
        #
        def request(args = {})
          make_request(
            http_method: :post,
            endpoint: path_for(:request),
            access_token: args.delete(:access_token),
            options: { body: args.to_json }
          )
        end
      end
    end
  end
end
