module Lyft
  class Client
    module Api
      class Rides < Lyft::Client::Api::Base
        ##
        # Cancel a ride request.
        # @see https://developer.lyft.com/docs/request-cancel
        #
        # @param access_token [String] The access_token (*required*)
        # @param params [Hash] The lyft parameters.
        # @option params [String] :ride_id (*required*)
        # @option params [String] :cancel_confirmation_token
        #
        def cancel(access_token:, params: {})
          ride_id = require_ride_id(params)
          resp = connection(access_token).post  do |req|
            req.url "/#{Api::VERSION}/rides/#{ride_id}/cancel"
            req.body = params
          end
          handle_response(resp)
        end

        ##
        # Update the ride destination
        # @see https://developer.lyft.com/docs/request-destination
        #
        # @param access_token [String] The access_token (*required*)
        # @param params [Hash] The lyft parameters.
        # @option params [String] :ride_id (*required*)
        # @option params [Float] :lat (*required*)
        # @option params [Float] :lng (*required*)
        # @option params [String] :address
        #
        def destination(access_token:, params: {})
          ride_id = require_ride_id(params)
          resp = connection(access_token).put do |req|
            req.url "/#{Api::VERSION}/rides/#{ride_id}/destination"
            req.body = params
          end
          handle_response(resp)
        end

        ##
        # Get details of a ride.
        # @see https://developer.lyft.com/docs/ride-request-details
        #
        # @param access_token [String] The access_token (*required*)
        # @param params [Hash] The lyft parameters.
        # @option params [String] :ride_id The ride id. (*required*)
        #
        def details(access_token:, params: {})
          ride_id = require_ride_id(params)
          resp = connection(access_token).get do |req|
            req.url "/#{Api::VERSION}/rides/#{ride_id}"
            req.body = params
          end
          handle_response(resp)
        end

        ##
        # Rate a ride and/or provide a tip.
        # @see https://developer.lyft.com/docs/ride-request-rating-and-tipping
        #
        # @param access_token [String] The access_token (*required*)
        # @param params [Hash] The lyft parameters.
        # @option params [String] :ride_id (*required*)
        # @option params [Integer] :rating Rating should be between 1 and 5 inclusive. (*required*)
        # @option params [Hash] :tip The tip should include :amount and :currency.
        # @option params [String] :feedback
        #
        def rate(access_token:, params: {})
          ride_id = require_ride_id(params)
          resp = connection(access_token).put do |req|
            req.url "/#{Api::VERSION}/rides/#{ride_id}/rating"
            req.body = params
          end
          handle_response(resp)
        end
        alias tip rate

        ##
        # Get receipt for ride
        # @see https://developer.lyft.com/docs/request-receipt
        #
        # @param access_token [String] The access_token (*required*)
        # @param params [Hash] The lyft parameters.
        # @option params [String] :ride_id (*required*)
        #
        def receipt(access_token:, params: {})
          ride_id = require_ride_id(params)
          resp = connection(access_token).get do |req|
            req.url "/#{Api::VERSION}/rides/#{ride_id}/receipt"
            req.params = params
          end
          handle_response(resp)
        end

        ##
        # Request a ride.
        # @see https://developer.lyft.com/docs/request
        #
        # @param access_token [String] The access_token (*required*)
        # @param params [Hash] The lyft parameters.
        # @option params [Hash] :origin The origin should contain :lat and :lng
        # @option params [Hash] :destination The destination should contain :lat and :lng.
        # @option params [String] :ride_type
        # @option params [String] :primetime_confirmation_token
        #
        def request(access_token:, params: {})
          resp = connection(access_token).post do |req|
            req.url "/#{Api::VERSION}/rides"
            req.body = params
          end
          handle_response(resp)
        end

        ##
        # Preset the ridetypes in area.
        #
        # @raise [RuntimeError] Raises if not in sandbox mode.
        # @param access_token [String] The access_token (*required*)
        # @param params [Hash] The lyft parameters.
        # @option params [Float] :lat (*required*)
        # @option params [Float] :lng (*required*)
        # @option params [Array<String>] :ride_types The ride types to make available.
        #   Accepted values are 'lyft', 'lyft_line', 'lyft_plus', and 'lyft_suv'.
        #
        def set_ridetypes(access_token:, params: {})
          validate_sandboxed
          resp = connection(access_token).put do |req|
            req.url "/#{Api::VERSION}/sandbox/ridetypes"
            req.body = params
          end
          handle_response(resp)
        end

        ##
        # Propogate ride through different states.
        #
        # @raise [RuntimeError] Raises if not in sandbox mode.
        # @param access_token [String] The access_token (*required*)
        # @param params [Hash] The lyft parameters.
        # @option params [String] :ride_id (*required*)
        # @option params [String] :status The status of the ride
        #
        def set_status(access_token:, params: {})
          validate_sandboxed
          ride_id = require_ride_id(params)
          resp = connection(access_token).put do |req|
            req.url "/#{Api::VERSION}/sandbox/rides/#{ride_id}"
            req.body = params
          end
          handle_response(resp)
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
        # @param access_token [String] The access_token (*required*)
        # @param params [Hash] The lyft parameters.
        # @option params [Float] :lat (*required*)
        # @option params [Float] :lng (*required*)
        # @option params [String] :primetime_percentage
        #
        def set_primetime(access_token:, params: {})
          validate_sandboxed
          resp = connection(access_token).put do |req|
            req.url "/#{Api::VERSION}/sandbox/primetime"
            req.body = params
          end
          handle_response(resp)
        end

        ##
        # Set driver availability for a ride type in an
        # area.
        #
        # @raise [RuntimeError] Raises if not in sandbox mode.
        # @raise [ArgumentError] Raises if invalid ride type.
        # @param access_token [String] The access_token (*required*)
        # @param params [Hash] The lyft parameters.
        # @option params [String] :ride_type (*required*)
        # @option params [Float] :lat (*required*)
        # @option params [Float] :lng (*required*)
        # @option params [Boolean] :driver_availability
        #
        def set_driver_availability(access_token:, params: {})
          validate_sandboxed
          ride_type = require_ride_type(params)
          resp = connection(access_token).put do |req|
            req.url "/#{Api::VERSION}/sandbox/ridetypes/#{ride_type}"
            req.body = params
          end
          handle_response(resp)
        end

        private

        ##
        # Validates if the current configuration is using lyft sandbox.
        # @raise [RuntimeError] Raises if not in sandbox mode.
        #
        def validate_sandboxed
          raise 'This method is only available in sandbox mode.' unless configuration.sandbox?
        end

        def validate_ride_type(params)
          return if Lyft::Ride::RIDE_TYPES.include?(params[:ride_type])
          raise ArgumentError, 'Invalid Ride Type'
        end

        def require_key(params, key)
          value = params.delete(key.to_sym)
          raise ArgumentError, "Missing param :#{key}" if value.blank?
          value
        end

        def require_ride_id(params)
          require_key(params, :ride_id)
        end

        def require_ride_type(params)
          require_key(params, :ride_type)
        end
      end
    end
  end
end
