require 'spec_helper'

set :os, :family => 'linux'

describe kernel_module('lp') do
  it { is_expected.to be_loaded }
end
