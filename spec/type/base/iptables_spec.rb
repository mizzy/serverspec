require 'spec_helper'

set :os, :family => 'base'

describe iptables do
  xit { should have_rule '-P INPUT ACCEPT' }
end

describe iptables do
  xit { should_not have_rule 'invalid-rule' }
end

describe iptables do
  xit { should have_rule('-P INPUT ACCEPT').with_table('mangle').with_chain('INPUT') }
end

describe iptables do
  xit { should_not have_rule('invalid-rule').with_table('mangle').with_chain('INPUT') }
end
