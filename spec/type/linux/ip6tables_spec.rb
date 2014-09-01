require 'spec_helper'

set :os, :family => 'linux'

describe ip6tables do
  it { should have_rule '-P INPUT ACCEPT' }
end

describe ip6tables do
  it { should have_rule('-P INPUT ACCEPT').with_table('mangle').with_chain('INPUT') }
end








