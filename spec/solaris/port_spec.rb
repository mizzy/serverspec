require 'spec_helper'

include Serverspec::Helper::Solaris

describe port(80) do
  it { should be_listening }
  its(:command) { should eq %q!netstat -an 2> /dev/null | egrep 'LISTEN|Idle' | grep -- .80\\ ! }
end

describe port('invalid') do
  it { should_not be_listening }
end
