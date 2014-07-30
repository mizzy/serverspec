require 'spec_helper'

set :os, :family => 'nixos'

describe package('httpd') do
  it { should be_installed }
end

describe package('invalid-package') do
  it { should_not be_installed }
end

describe package('invalid-package') do
  it { should_not be_installed.by('nix') }
end

describe package('httpd') do
  it { should be_installed.with_version('2.2.15-28.el6') }
end

describe package('httpd') do
  it { should be_installed.by('nix').with_version('2.2.15-28.el6') }
end

describe package('httpd') do
  it { should_not be_installed.with_version('invalid-version') }
end
