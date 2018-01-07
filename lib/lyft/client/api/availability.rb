module Lyft
  class Client
    module Api
      class Availability < Lyft::Client::Api::Base
        ##
        # Get the estimated cost of ride.
        #
        # @example Get the estimated cost of a ride.
        #   client.availability.cost(
        #     access_token: 'token',
        #     params: {
        #       start_lat: 37.7772,
        #       start_lng: -122.4233,
        #       end_lat: 37.7972,
        #       end_lng: -122.4533
        #     }
        #   )
        #
        # @param access_token [String] The access_token (*required*)
        # @param params [Hash] The lyft parameters.
        # @option params [Float] :start_lat The latitude of starting point. (*required*)
        # @option params [Float] :start_lng The longitude of starting point. (*required*)
        # @option params [Float] :end_lat The latitude of the end point. (*required*)
        # @option params [Float] :end_lng The longitude of the end point. (*required*)
        #
        def cost(access_token:, params: {})
          resp = connection(access_token).get do |req|
            req.url "/#{Api::VERSION}/cost"
            req.params = params
          end
          handle_response(resp)
        end

        ##
        # Get eta for lyft driver to reach location
        #
        # @example Get lyft eta to a specified location.
        #   client.availability.eta access_token: 'my_token',
        #                           params: { lat: 37.7772, lng: -122.4233 }
        #
        # @param access_token [String] The access_token (*required*)
        # @param params [Hash] The lyft parameters.
        # @option params [Float] :lat The latitude of pickup. (*required*)
        # @option params [Float] :lng The longitude of pickup. (*required*)
        #
        def eta(access_token:, params: {})
          resp = connection(access_token).get do |req|
            req.url "/#{Api::VERSION}/eta"
            req.params = params
          end
          handle_response(resp)
        end

        ##
        # Get positions of nearby drivers
        #
        # @example Get location of nearby drivers.
        #   client.availability.nearby_drivers access_token: 'my_token',
        #                                      params: { lat: 37.7772, lng: -122.4233 }
        #
        # @param access_token [String] The access_token (*required*)
        # @param params [Hash] The lyft parameters.
        # @option params [Float] :lat The latitude of pickup. (*required*)
        # @option params [Float] :lng The longitude of pickup. (*required*)
        #
        def nearby_drivers(access_token:, params: {})
          resp = connection(access_token).get do |req|
            req.url "/#{Api::VERSION}/drivers"
            req.params = params
          end
          handle_response(resp)
        end

        ##
        # Get available lyft ride types
        #
        # @example Get available ride types for a location.
        #   client.availability.ride_types access_token: 'my_token',
        #                                  params: { lat: 37.7772, lng: -122.4233 }
        #
        # @param access_token [String] The access_token (*required*)
        # @param params [Hash] The lyft parameters.
        # @option params [Float] :lat The latitude of pickup. (*required*)
        # @option params [Float] :lng The longitude of pickup. (*required*)
        #
        def ride_types(access_token:, params: {})
          resp = connection(access_token).get do |req|
            req.url "/#{Api::VERSION}/ridetypes"
            req.params = params
          end
          handle_response(resp)
        end
      end
    end
  end
end
