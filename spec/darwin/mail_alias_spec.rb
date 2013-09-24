require 'spec_helper'

RSpec.configure do |c|
  c.os = 'Darwin'
end

describe mail_alias('daemon') do
  it { should be_aliased_to "root" }
  its(:command) { should eq "getent aliases daemon | grep -- \\[\\[:space:\\]\\]root$" }
end

describe mail_alias('invalid-recipient') do
  it { should_not be_aliased_to "foo" }
end
