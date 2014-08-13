require 'spec_helper'

set :os, :family => 'redhat'

describe yumrepo('epel') do
  it { should exist }
end

describe yumrepo('epel') do
  it { should be_enabled }
end
