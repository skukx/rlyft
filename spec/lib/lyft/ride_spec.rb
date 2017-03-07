require 'spec_helper'

describe Lyft::Ride do
  its(:constants) { is_expected.to include :RIDE_TYPES }
  its(:constants) { is_expected.to include :RIDE_STATUSES }
end

describe Lyft::Ride::RIDE_TYPES do
  it { is_expected.to be_kind_of Array }
  it { is_expected.to include Lyft::Ride::Type::LYFT }
  it { is_expected.to include Lyft::Ride::Type::LYFT_PLUS }
  it { is_expected.to include Lyft::Ride::Type::LYFT_LINE }
  it { is_expected.to include Lyft::Ride::Type::LYFT_SUV }
end

describe Lyft::Ride::RIDE_STATUSES do
  it { is_expected.to be_kind_of Array }
  it { is_expected.to include Lyft::Ride::Status::PENDING }
  it { is_expected.to include Lyft::Ride::Status::ACCEPTED }
  it { is_expected.to include Lyft::Ride::Status::ARRIVED }
  it { is_expected.to include Lyft::Ride::Status::PICKED_UP }
  it { is_expected.to include Lyft::Ride::Status::DROPPED_OFF }
  it { is_expected.to include Lyft::Ride::Status::CANCELED }
  it { is_expected.to include Lyft::Ride::Status::UNKNOWN }
end
