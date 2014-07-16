require 'spec_helper'

set :os, :family => 'base'

describe kernel_module('lp') do
  xit { should be_loaded }
end

describe kernel_module('invalid-module') do
  xit { should_not be_loaded }
end
