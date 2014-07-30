require 'spec_helper'

set :os, :family => 'openbsd'

describe mail_alias('daemon') do
  it { should be_aliased_to "root" }
end

describe mail_alias('invalid-recipient') do
  it { should_not be_aliased_to "foo" }
end
