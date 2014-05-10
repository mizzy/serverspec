require 'spec_helper'

include SpecInfra::Helper::Solaris11

describe port(80) do
  it { should be_listening }
  its(:command) { should eq %q!netstat -an 2> /dev/null | grep -- LISTEN | grep -- \\\\.80\\ ! }
end

describe port('invalid') do
  it { should_not be_listening }
end
