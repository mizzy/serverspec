require 'spec_helper'

set :os, :family => 'base'

describe kernel_module('lp') do
  it { should be_loaded }
end

describe kernel_module('invalid-module') do
  it { should_not be_loaded }
end
