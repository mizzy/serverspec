require 'spec_helper'

include Serverspec::Helper::Debian

describe 'Serverspec service matchers of Debian family' do
  it_behaves_like 'support file be_file matcher', '/etc/ssh/sshd_config'
  it_behaves_like 'support file be_directory matcher', '/etc/ssh'
  it_behaves_like 'support file contain matcher', '/etc/ssh/sshd_config', 'This is the sshd server system-wide configuration file'
  it_behaves_like 'support file contain from to matcher', 'Gemfile', 'rspec', /^group :test do/, /^end/
  it_behaves_like 'support file contain after matcher', 'Gemfile', 'rspec', /^group :test do/
  it_behaves_like 'support file contain before matcher', 'Gemfile', 'rspec', /^end/
end
