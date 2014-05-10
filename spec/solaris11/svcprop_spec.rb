require 'spec_helper'

include SpecInfra::Helper::Solaris11

describe service('svc:/network/http:apache22') do
  it { should have_property 'httpd/enable_64bit' => false }
  its(:command) { should eq "svcprop -p httpd/enable_64bit svc:/network/http:apache22 | grep -- \\^false\\$" }
end

describe service('svc:/network/http:apache22') do
  it { should have_property 'httpd/enable_64bit' => false, 'httpd/server_type'  => 'worker' }
  its(:command) { should eq "svcprop -p httpd/enable_64bit svc:/network/http:apache22 | grep -- \\^false\\$ && svcprop -p httpd/server_type svc:/network/http:apache22 | grep -- \\^worker\\$" }
end
