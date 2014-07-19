require 'spec_helper'

set :os, :family => 'redhat'

describe package('httpd') do
  xit { should be_installed }
end

describe package('invalid-package') do
  xit { should_not be_installed }
end


describe package('invalid-package') do
  xit { should_not be_installed.by('rpm') }
end

describe package('httpd') do
  xit { should be_installed.with_version('2.2.15-28.el6') }
end

describe package('httpd') do
  xit { should be_installed.by('rpm').with_version('2.2.15-28.el6') }
end

describe package('httpd') do
  xit { should_not be_installed.with_version('invalid-version') }
end

describe package('httpd') do
  let(:stdout) { "2.2.15\n" }
  its(:version) { pending; should eq '2.2.15' }
  its(:version) { pending; should > '2.2.14' }
  its(:version) { pending; should < '2.2.16' }
  its(:version) { pending; should > '2.2.9' }
end
