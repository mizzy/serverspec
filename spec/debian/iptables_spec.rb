require 'spec_helper'

include Serverspec::Helper::Debian

describe 'Serverspec iptables matchers of Debian family' do
  it_behaves_like 'support iptables have_rule matcher', '-P INPUT ACCEPT'
  it_behaves_like 'support iptables have_rule with_table and with_chain matcher', '-P INPUT ACCEPT', 'mangle', 'INPUT'
end
