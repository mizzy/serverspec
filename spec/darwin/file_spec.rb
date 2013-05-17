require 'spec_helper'

include Serverspec::Helper::Darwin

describe 'Serverspec service matchers of Darwin family' do
  it_behaves_like 'support file be_file matcher', '/etc/ssh/sshd_config'
  it_behaves_like 'support file be_directory matcher', '/etc/ssh'
  it_behaves_like 'support file contain matcher', '/etc/ssh/sshd_config', 'This is the sshd server system-wide configuration file'
  it_behaves_like 'support file contain from to matcher', 'Gemfile', 'rspec', /^group :test do/, /^end/
  it_behaves_like 'support file contain after matcher', 'Gemfile', 'rspec', /^group :test do/
  it_behaves_like 'support file contain before matcher', 'Gemfile', 'rspec', /^end/
  it_behaves_like 'support be_mode matcher', '/etc/passwd', 644
  it_behaves_like 'support be_owned_by matcher', '/etc/passwd', 'root'
  it_behaves_like 'support be_grouped_into matcher', '/etc/passwd', 'root'
  it_behaves_like 'support be_linked_to matcher', '/etc/pam.d/system-auth', '/etc/pam.d/system-auth-ac'
end
