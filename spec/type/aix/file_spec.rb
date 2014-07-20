require 'spec_helper'

set :os, {:family => 'aix'}

describe commands.command_class('file').create do
  it { should be_an_instance_of(Specinfra::Command::Aix::Base::File) }
end

describe file('/tmp') do
  it { should be_readable.by_user('mail') }
end

describe file('/tmp') do
  it { should be_writable.by_user('mail') }
end

describe file('/tmp') do
  it { should be_executable.by_user('mail') }
end

describe file('/etc/passwd') do
  it 'be_mode is not implemented' do
    expect {
      should be_mode 644
    }.to raise_error(Specinfra::Command::Base::NotImplementedError)
  end
end

describe file('/etc/passwd') do
  it { should be_owned_by 'root' }
end

describe file('/etc/passwd') do
  it { should be_grouped_into 'root' }
end
