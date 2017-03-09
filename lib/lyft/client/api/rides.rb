module Lyft
  class Client
    module Api
      class Rides < Lyft::Client::Api::Base
        headers 'Content-Type': 'application/json'

        ENDPOINTS = {
          request: "/#{API_VERSION}/rides",
          details: "/#{API_VERSION}/rides/{{ride_id}}",
          cancel: "/#{API_VERSION}/rides/{{ride_id}}/cancel",
          rating: "/#{API_VERSION}/rides/{{ride_id}}/rating",
          receipt: "/#{API_VERSION}/rides/{{ride_id}}/receipt",
          destination: "/#{API_VERSION}/rides/{{ride_id}}/destination",
          sandbox_primetime: "/#{API_VERSION}/sandbox/primetime",
          sandbox_rides: "/#{API_VERSION}/sandbox/rides/{{ride_id}}",
          sandbox_ridetypes: "/#{API_VERSION}/sandbox/ridetypes/{{ride_type}}"
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
        alias_method :tip, :rate

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

        ##
        # Preset the ridetypes in area.
        #
        # @raise [RuntimeError] Raises if not in sandbox mode.
        # @param [Hash] args
        # @option args [String] :access_token (*required*)
        # @option args [Float] :lat (*required*)
        # @option args [Float] :lng (*required*)
        # @option args [Array<String>] :ride_types The ride types to make available.
        #   Accepted values are 'lyft', 'lyft_line', 'lyft_plus', and 'lyft_suv'.
        #
        def set_ridetypes(args = {})
          validate_sandboxed
          make_request(
            http_method: :put,
            endpoint: path_for(:sandbox_ridetypes),
            access_token: args.delete(:access_token),
            options: { body: args.to_json }
          )
        end

        ##
        # Propogate ride through different states.
        #
        # @raise [RuntimeError] Raises if not in sandbox mode.
        # @param [Hash] args
        # @option args [String] :access_token (*required*)
        # @option args [String] :ride_id (*required*)
        # @option args [String] :status The status of the ride
        #
        def set_status(args = {})
          validate_sandboxed
          make_request(
            http_method: :put,
            endpoint: path_for(:sandbox_rides, ride_id: args.delete(:ride_id)),
            access_token: args.delete(:access_token),
            options: { body: args.to_json }
          )
        end

        ##
        # Set the primetime percentage in area
        #
        # @example Set the prime time percentage.
        #   client.rides.set_primetime(
        #     access_token: 'my_token',
        #     lat: 37.7833,
        #     lng: -122.4167,
        #     primetime_percentage: '25%'
        #   )
        #
        # @raise [RuntimeError] Raises if not in sandbox mode.
        # @param [Hash] args
        # @option args [String] :access_token (*required*)
        # @option args [Float] :lat (*required*)
        # @option args [Float] :lng (*required*)
        # @option args [String] :primetime_percentage
        #
        def set_primetime(args = {})
          validate_sandboxed
          make_request(
            http_method: :put,
            endpoint: path_for(:sandbox_primetime),
            access_token: args.delete(:access_token),
            options: { body: args.to_json }
          )
        end

        ##
        # Set driver availability for a ride type in an
        # area.
        #
        # @raise [RuntimeError] Raises if not in sandbox mode.
        # @raise [ArgumentError] Raises if invalid ride type.
        # @option args [String] :access_token (*required*)
        # @option args [String] :ride_type (*required*)
        # @option args [Float] :lat (*required*)
        # @option args [Float] :lng (*required*)
        # @option args [Boolean] :driver_availability
        #
        def set_driver_availability(args = {})
          validate_sandboxed
          raise ArgumentError, 'Invalid Ride Type' unless Lyft::Ride::RIDE_TYPES.include? args[:ride_type]

          make_request(
            http_method: :put,
            endpoint: path_for(:sandbox_ridetypes, ride_type: args.delete(:ride_type)),
            access_token: args.delete(:access_token),
            options: { body: args.to_json }
          )
        end

        private

        ##
        # Validates if the current configuration is using lyft sandbox.
        # @raise [RuntimeError] Raises if not in sandbox mode.
        #
        def validate_sandboxed
          raise 'This method is only available in sandbox mode.' unless @configuration.sandbox?
        end
      end
    end
  end
end
