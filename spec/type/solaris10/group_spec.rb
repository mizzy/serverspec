require 'spec_helper'

set :os, :family => 'solaris', :release => 10

describe group('root') do
  it { is_expected.to exist }
end

