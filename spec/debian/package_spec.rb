require 'spec_helper'

include SpecInfra::Helper::Debian

describe package('apache2') do
  it { should be_installed }
  its(:command) { should eq "dpkg-query -f '${Status}' -W apache2 | grep -E '^(install|hold) ok installed$'" }
end

describe package('invalid-package') do
  it { should_not be_installed }
end

describe package('apache2') do
  it { should be_installed.with_version('1.1.1') }
  its(:command) { should eq "dpkg-query -f '${Status} ${Version}' -W apache2 | grep -E '^(install|hold) ok installed 1.1.1$'" }
end

describe package('invalid-package') do
  it { should_not be_installed.with_version('invalid-version') }
end

describe package('jekyll') do
  it { should be_installed.by('gem') }
  its(:command) { should eq "gem list --local | grep -w -- \\^jekyll" }
end

describe package('invalid-gem') do
  it { should_not be_installed.by('gem') }
end

describe package('jekyll') do
  it { should be_installed.by('gem').with_version('1.1.1') }
  its(:command) { should eq "gem list --local | grep -w -- \\^jekyll | grep -w -- 1.1.1" }
end

describe package('jekyll') do
  it { should_not be_installed.by('gem').with_version('invalid-version') }
end

describe package('bower') do
  it { should be_installed.by('npm') }
  its(:command) { should eq "npm ls bower -g" }
end

describe package('invalid-npm-package') do
  it { should_not be_installed.by('npm') }
end

describe package('bower') do
  it { should be_installed.by('npm').with_version('0.9.2') }
  its(:command) { should eq "npm ls bower -g | grep -w -- 0.9.2" }
end

describe package('bower') do
  it { should_not be_installed.by('npm').with_version('invalid-version') }
end


describe package('mongo') do
  it { should be_installed.by('pecl') }
  its(:command) { should eq "pecl list | grep -w -- \\^mongo" }
end

describe package('invalid-pecl') do
  it { should_not be_installed.by('pecl') }
end

describe package('mongo') do
  it { should be_installed.by('pecl').with_version('1.4.1') }
  its(:command) { should eq "pecl list | grep -w -- \\^mongo | grep -w -- 1.4.1" }
end

describe package('mongo') do
  it { should_not be_installed.by('pecl').with_version('invalid-version') }
end

describe package('XML_Util') do
  it { should be_installed.by('pear').with_version('1.2.1') }
  its(:command) { should eq "pear list | grep -w -- \\^XML_Util | grep -w -- 1.2.1" }
end

describe package('supervisor') do
  it { should be_installed.by('pip').with_version('3.0') }
  its(:command) { should eq "pip list | grep -w -- \\^supervisor | grep -w -- 3.0" }
end

describe package('invalid-pip') do
  it { should_not be_installed.by('pip').with_version('invalid-version') }
end

describe package('App::Ack') do
  it { should be_installed.by('cpan') }
  its(:command) { should eq "cpan -l | grep -w -- \\^App::Ack" }
end

describe package('App::Ack') do
  it { should be_installed.by('cpan').with_version('2.04') }
  its(:command) { should eq "cpan -l | grep -w -- \\^App::Ack | grep -w -- 2.04" }
end

describe package('httpd') do
  let(:stdout) { "2.2.15\n" }
  its(:version) { should eq '2.2.15' }
  its(:version) { should > '2.2.14' }
  its(:version) { should < '2.2.16' }
  its(:command) { should eq "dpkg-query -f '${Status} ${Version}' -W httpd | sed -n 's/^install ok installed //p'" }
end

# Debian-style versions
describe package('httpd') do
  let(:stdout) { "2.2.15-3\n" }
  its(:version) { should eq '2.2.15-3' }
  its(:version) { should > '2.2.15' }
  its(:version) { should < '2.2.16' }
  its(:version) { should < '2.2.15-4' }
  its(:version) { should > '2.2.15-3~bpo70+1' }
end

# With some epoch
describe package('httpd') do
  let(:stdout) { "3:2.2.15-3~git20120918+ae4569bc\n" }
  its(:version) { should eq '3:2.2.15-3~git20120918+ae4569bc' }
  its(:version) { should > '3:2.2.15-3~git20120912+ae4569bc' }
  its(:version) { should < '3:2.2.15-3' }
  its(:version) { should < '3:2.2.15-3+feature1' }
  its(:version) { should < '4:1.2.15' }
  its(:version) { should > '2:4.2.15' }
  its(:version) { should > '14.2.15' }
end
