require 'spec_helper'

set :os, :family => 'linux'

describe iptables do
  it { is_expected.to have_rule '-P INPUT ACCEPT' }
end

describe iptables do
  it { is_expected.to have_rule('-P INPUT ACCEPT').with_table('mangle').with_chain('INPUT') }
end
