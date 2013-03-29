require 'spec_helper'

include Serverspec::RedHatHelper

describe commands.check_enabled('httpd') do
  it { should eq 'chkconfig --list httpd | grep 3:on' }
end
