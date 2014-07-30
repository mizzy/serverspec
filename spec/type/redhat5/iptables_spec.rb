require 'spec_helper'

set :os, :family => 'redhat', :release => 5

describe iptables do
  it { should have_rule '-P INPUT ACCEPT' }
end

describe iptables do
  it { should_not have_rule 'invalid-rule' }
end

describe iptables do
  it { should have_rule('-P INPUT ACCEPT').with_table('mangle').with_chain('INPUT') }
end

describe iptables do
  it { should_not have_rule('invalid-rule').with_table('mangle').with_chain('INPUT') }
end
