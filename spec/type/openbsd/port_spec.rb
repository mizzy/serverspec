require 'spec_helper'

set :os, :family => 'openbsd'

describe port(80) do
  it { should be_listening }
end
