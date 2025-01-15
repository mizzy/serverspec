require 'spec_helper'

set :os, :family => 'solaris'

describe ipnat do
  it { is_expected.to have_rule 'map net1 192.168.0.0/24 -> 0.0.0.0/32' }
end
