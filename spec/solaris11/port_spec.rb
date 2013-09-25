require 'spec_helper'

RSpec.configure do |c|
  c.os      = 'Solaris11'
  c.backend = 'Exec'
end

describe port(80) do
  it { should be_listening }
  its(:command) { should eq %q!netstat -an 2> /dev/null | grep -- LISTEN | grep -- \\\\.80\\ ! }
end

describe port('invalid') do
  it { should_not be_listening }
end
