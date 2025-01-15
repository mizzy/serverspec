require 'spec_helper'

set :os, :family => 'openbsd'

describe port(80) do
  it { is_expected.to be_listening }
end
