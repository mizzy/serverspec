require 'spec_helper'

include Serverspec::Helper::Solaris

describe service('svc:/network/http:apache22') do
  it { should have_property 'httpd/enable_64bit' => false }
  it { should have_property 'httpd/enable_64bit' => false, 'httpd/server_type'  => 'worker' }
end
