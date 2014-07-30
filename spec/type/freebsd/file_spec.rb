require 'spec_helper'

set :os, :family => 'freebsd'

describe file('/tmp') do
  it { should be_mode 777 }
end
