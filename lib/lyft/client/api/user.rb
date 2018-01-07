module Lyft
  class Client
    module Api
      class User < Lyft::Client::Api::Base
        ##
        # Get ride history
        #
        # @param access_token [String] The access_token (*required*)
        # @param params [Hash] The lyft parameters.
        # @option params [DateTime] :start_time (*required*)
        # @option params [DateTime] :end_time
        # @option params [Integer] :limit
        #
        def ride_history(access_token:, params: {})
          params.delete(:end_time) if params[:end_time].blank?
          params.delete(:limit) if params[:limit].blank?

          resp = connection(access_token).get do |req|
            req.url "/#{Api::VERSION}/rides"
            req.params = params
          end
          handle_response(resp)
        end

        ##
        # Get user's profile
        #
        # @param access_token [String] The access_token (*required*)
        # @param params [Hash] The lyft parameters.
        #
        def profile(access_token:, params: {})
          resp = connection(access_token).get do |req|
            req.url "/#{Api::VERSION}/profile"
            req.params = params
          end
          handle_response(resp)
        end
      end
    end
  end
end
