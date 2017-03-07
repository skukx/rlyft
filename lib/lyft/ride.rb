require 'lyft/ride/status'
require 'lyft/ride/type'

module Lyft
  module Ride
    ##
    # List of values for ride types
    # @return [Array<String>] A list of ride type values
    #
    RIDE_TYPES = Lyft::Ride::Type.constants.map { |c| Lyft::Ride::Type.const_get(c) }

    ##
    # List of values for ride status
    # @return [Array<String>] A list of ride status values
    #
    RIDE_STATUSES = Lyft::Ride::Status.constants.map { |c| Lyft::Ride::Status.const_get(c) }
  end
end
