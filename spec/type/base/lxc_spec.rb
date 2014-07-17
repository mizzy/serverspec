require 'spec_helper'

set :os, :family => 'base'

describe lxc('ct01') do
  xit { should exist }
end

describe lxc('invalid-ct') do
  xit { should_not exist }
end

describe lxc('ct01') do
  xit { should be_running }
end

describe lxc('invalid-ct') do
  xit { should_not be_running }
end

