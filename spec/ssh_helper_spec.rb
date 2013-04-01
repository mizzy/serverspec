require 'spec_helper'

include Serverspec::SshHelper

describe 'get the command stdout' do
  subject do
    get_stdout('whoami')
  end

  before do
    RSpec.configure do |c|
      c.stdout = "root\r\n"
    end
  end

  it { should eq "root\r\n" }
  it { should match /root/ }
end
