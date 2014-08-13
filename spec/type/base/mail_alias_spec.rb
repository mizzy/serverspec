require 'spec_helper'

set :os, :family => 'base'

describe mail_alias('daemon') do
  it { should be_aliased_to "root" }
end
