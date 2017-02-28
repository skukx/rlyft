require 'lyft/ride/status'
require 'lyft/ride/type'

module Lyft
  module Ride
    ##
    # List of values for ride types
    # @return [Array<String>] A list of ride type values
    #
    RIDE_TYPES = [
      Lyft::Ride::Type::LYFT,
      Lyft::Ride::Type::LYFT_LINE,
      Lyft::Ride::Type::LYFT_PLUS,
      Lyft::Ride::Type::LYFT_SUV
    ]

    ##
    # List of values for ride status
    # @return [Array<String>] A list of ride status values
    #
    RIDE_STATUSES = [
      Lyft::Ride::Status::PENDING,
      Lyft::Ride::Status::ACCEPTED,
      Lyft::Ride::Status::ARRIVED,
      Lyft::Ride::Status::PICKED_UP,
      Lyft::Ride::Status::DROPPED_OFF,
      Lyft::Ride::Status::CANCELED,
      Lyft::Ride::Status::UNKNOWN,
    ]
  end
end
