require 'spec_helper'

set :os, :family => 'redhat', :release => 5

describe iptables do
  it { is_expected.to have_rule '-P INPUT ACCEPT' }
end

describe iptables do
  it { is_expected.to have_rule('-P INPUT ACCEPT').with_table('mangle').with_chain('INPUT') }
end
