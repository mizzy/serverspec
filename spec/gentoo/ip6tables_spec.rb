require 'spec_helper'

include SpecInfra::Helper::Gentoo

describe ip6tables do
  it { should have_rule '-P INPUT ACCEPT'  }
  its(:command) { should eq "ip6tables -S | grep -- -P\\ INPUT\\ ACCEPT || ip6tables-save | grep -- -P\\ INPUT\\ ACCEPT" }
end

describe ip6tables do
  it { should_not have_rule 'invalid-rule' }
end

describe ip6tables do
  it { should have_rule('-P INPUT ACCEPT').with_table('mangle').with_chain('INPUT') }
  its(:command) { should eq "ip6tables -t mangle -S INPUT | grep -- -P\\ INPUT\\ ACCEPT || ip6tables-save -t mangle | grep -- -P\\ INPUT\\ ACCEPT" }
end

describe ip6tables do
  it { should_not have_rule('invalid-rule').with_table('mangle').with_chain('INPUT') }
end
