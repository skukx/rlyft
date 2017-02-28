module Lyft
  class Client
    module Api
      class User < Lyft::Client::Api::Base
        ENDPOINTS = {
          history: "/#{API_VERSION}/rides",
          profile: "/#{API_VERSION}/profile"
        }

        ##
        # Get ride history
        #
        # @param [Hash] args
        # @option args [String] :access_token (*required*)
        # @option args [DateTime] :start_time (*required*)
        # @option args [DateTime] :end_time
        # @option args [Integer] :limit
        #
        def ride_history(args = {})
          args.delete(:end_time) if args[:end_time].blank?
          args.delete(:limit) if args[:limit].blank?

          make_request(
            http_method: :get,
            endpoint: path_for(:history),
            access_token: args.delete(:access_token),
            options: { query: args }
          )
        end

        ##
        # Get user's profile
        #
        # @param [Hash] args
        # @option args [String] :access_token (*required*)
        #
        def profile(args = {})
          make_request(
            http_method: :get,
            endpoint: path_for(:profile),
            access_token: args.delete(:access_token),
            options: { query: args }
          )
        end
      end
    end
  end
end
