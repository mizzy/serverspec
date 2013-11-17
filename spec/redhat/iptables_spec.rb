require 'spec_helper'

include Serverspec::Helper::RedHat

describe iptables do
  it { should have_rule '-P INPUT ACCEPT'  }
  its(:command) { should eq "iptables -S | grep -- -P\\ INPUT\\ ACCEPT" }
end

describe iptables do
  it { should_not have_rule 'invalid-rule' }
end

describe iptables do
  it { should have_rule('-P INPUT ACCEPT').with_table('mangle').with_chain('INPUT') }
  its(:command) { should eq "iptables -t mangle -S INPUT | grep -- -P\\ INPUT\\ ACCEPT" }
end

describe iptables do
  it { should_not have_rule('invalid-rule').with_table('mangle').with_chain('INPUT') }
end
