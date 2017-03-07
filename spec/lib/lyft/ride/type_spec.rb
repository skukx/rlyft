require 'spec_helper'

describe Lyft::Ride::Type do
  it { is_expected.to be_const_defined :LYFT }
  it { is_expected.to be_const_defined :LYFT_PLUS }
  it { is_expected.to be_const_defined :LYFT_LINE }
  it { is_expected.to be_const_defined :LYFT_SUV }
end
