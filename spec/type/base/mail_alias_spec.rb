require 'spec_helper'

set :os, :family => 'base'

describe mail_alias('daemon') do
  it { is_expected.to be_aliased_to "root" }
end
