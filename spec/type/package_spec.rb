require 'spec_helper'

set :os, :family => 'redhat'

describe package('httpd') do
  it { should be_installed }
end

describe package('invalid-package') do
  it { should_not be_installed }
end

describe package('invalid-package') do
  it { should_not be_installed.by('rpm') }
end

describe package('httpd') do
  it { should be_installed.with_version('2.2.15-28.el6') }
end

describe package('httpd') do
  it { should be_installed.by('rpm').with_version('2.2.15-28.el6') }
end

describe package('httpd') do
  it { should_not be_installed.with_version('invalid-version') }
end

describe package('jekyll') do
  it { should be_installed.by('gem') }
end

describe package('invalid-gem') do
  it { should_not be_installed.by('gem') }
end

describe package('jekyll') do
  it { should be_installed.by('gem').with_version('1.1.1') }
end

describe package('jekyll') do
  it { should_not be_installed.by('gem').with_version('invalid-version') }
end

describe package('bower') do
  it { should be_installed.by('npm') }
end

describe package('invalid-npm-package') do
  it { should_not be_installed.by('npm') }
end

describe package('bower') do
  it { should be_installed.by('npm').with_version('0.9.2') }
end

describe package('bower') do
  it { should_not be_installed.by('npm').with_version('invalid-version') }
end


describe package('mongo') do
  it { should be_installed.by('pecl') }
end

describe package('invalid-pecl') do
  it { should_not be_installed.by('pecl') }
end

describe package('mongo') do
  it { should be_installed.by('pecl').with_version('1.4.1') }
end

describe package('mongo') do
  it { should_not be_installed.by('pecl').with_version('invalid-version') }
end

describe package('XML_Util') do
  it { should be_installed.by('pear').with_version('1.2.1') }
end

describe package('supervisor') do
  it { should be_installed.by('pip').with_version('3.0') }
end

describe package('invalid-pip') do
  it { should_not be_installed.by('pip').with_version('invalid-version') }
end

describe package('App::Ack') do
  it { should be_installed.by('cpan') }
end

describe package('App::Ack') do
  it { should be_installed.by('cpan').with_version('2.04') }
end

describe package('httpd') do
  let(:stdout) { "2.2.15\n" }
  its(:version) { should eq '2.2.15' }
  its(:version) { should > '2.2.14' }
  its(:version) { should < '2.2.16' }
  its(:version) { should > '2.2.9' }
end
