require 'spec_helper'

describe Lyft::Ride::Status do
  it { is_expected.to be_const_defined :PENDING }
  it { is_expected.to be_const_defined :ACCEPTED }
  it { is_expected.to be_const_defined :ARRIVED }
  it { is_expected.to be_const_defined :PICKED_UP }
  it { is_expected.to be_const_defined :DROPPED_OFF }
  it { is_expected.to be_const_defined :CANCELED }
  it { is_expected.to be_const_defined :UNKNOWN }
end
