require 'spec_helper'

set :os, :family => 'linux'

describe kernel_module('lp') do
  it { should be_loaded }
end
