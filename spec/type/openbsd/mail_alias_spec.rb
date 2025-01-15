require 'spec_helper'

set :os, :family => 'openbsd'

describe mail_alias('daemon') do
  it { is_expected.to be_aliased_to "root" }
end
