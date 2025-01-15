require 'spec_helper'

set :os, :family => 'base'

describe group('root') do
  it { is_expected.to exist }
end

describe group('root') do
  it { is_expected.to have_gid 0 }
end

describe group('root') do
  its(:gid) { is_expected.to == 0 }
  its(:gid) { is_expected.to < 10 }
end
