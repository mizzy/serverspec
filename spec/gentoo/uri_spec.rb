require 'spec_helper'

include SpecInfra::Helper::Gentoo

describe uri('http://www.google.ie') do
  let(:stdout) { "HTTP/1.1 200 OK" }
  it { should return_status_code_on_get(200) }
  its(:command) { should eq "curl -i http://www.google.ie" }
end

describe uri('http://www.gsoogle.ie') do
  let(:stdout) { "HTTP/1.1 404" }
  it { should return_status_code_on_get(404) }
  its(:command) { should eq "curl -i http://www.gsoogle.ie" }
end
