module Lyft
  class Client
    module Api
      class Availability < Lyft::Client::Api::Base
        ENDPOINTS = {
          cost: "/#{API_VERSION}/cost",
          eta: "/#{API_VERSION}/eta",
          nearby_drivers: "/#{API_VERSION}/drivers",
          ride_types: "/#{API_VERSION}/ridetypes"
        }

        ##
        # Get the estimated cost of ride.
        #
        # @example Get the estimated cost of a ride.
        #   client.availability.cost(
        #     start_lat: 37.7772,
        #     start_lng: -122.4233,
        #     end_lat: 37.7972,
        #     end_lng: -122.4533,
        #     access_token: 'token'
        #   )
        #
        # @param [Hash] args
        # @option args [String] :access_token (*required*)
        # @option args [Float] :start_lat The latitude of starting point. (*required*)
        # @option args [Float] :start_lng The longitude of starting point. (*required*)
        # @option args [Float] :end_lat The latitude of the end point. (*required*)
        # @option args [Float] :end_lng The longitude of the end point. (*required*)
        #
        def cost(args = {})
          make_request(
            http_method: :get,
            endpoint: path_for(:cost),
            access_token: args.delete(:access_token),
            options: { query: args }
          )
        end

        ##
        # Get eta for lyft driver to reach location
        #
        # @example Get lyft eta to a specified location.
        #   client.availability.eta lat: 37.7772,
        #                           lng: -122.4233
        #                           access_token: 'token'
        #
        # @param [Hash] args
        # @option args [String] :access_token (*required*)
        # @option args [Float] :lat The latitude of pickup. (*required*)
        # @option args [Float] :lng The longitude of pickup. (*required*)
        #
        def eta(args = {})
          make_request(
            http_method: :get,
            endpoint: path_for(:eta),
            access_token: args.delete(:access_token),
            options: { query: args }
          )
        end

        ##
        # Get positions of nearby drivers
        #
        # @example Get location of nearby drivers.
        #   client.availability.nearby_drivers lat: 37.7772,
        #                                      lng: -122.4233,
        #                                      access_token: 'token'
        #
        # @param [Hash] args
        # @option args [String] :access_token (*required*)
        # @option args [Float] :lat The latitude of pickup. (*required*)
        # @option args [Float] :lng The longitude of pickup. (*required*)
        #
        def nearby_drivers(args = {})
          make_request(
            http_method: :get,
            endpoint: path_for(:nearby_drivers),
            access_token: args.delete(:access_token),
            options: { query: args }
          )
        end

        ##
        # Get available lyft ride types
        #
        # @example Get available ride types for a location.
        #   client.availability.ride_types lat: 37.7772,
        #                                  lng: -122.4233
        #
        # @param [Hash] args
        # @option args [String] :access_token (*required*)
        # @option args [Float] :lat The latitude of pickup. (*required*)
        # @option args [Float] :lng The longitude of pickup. (*required*)
        #
        def ride_types(args = {})
          make_request(
            http_method: :get,
            endpoint: path_for(:nearby_drivers),
            access_token: args.delete(:access_token),
            options: { query: args }
          )
        end
      end
    end
  end
end
