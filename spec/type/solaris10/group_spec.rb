require 'spec_helper'

set :os, :family => 'solaris', :release => 10

describe group('root') do
  it { should exist }
end

