require 'spec_helper'

set :os, :family => 'redhat'

describe yumrepo('epel') do
  it { is_expected.to exist }
end

describe yumrepo('epel') do
  it { is_expected.to be_enabled }
end
