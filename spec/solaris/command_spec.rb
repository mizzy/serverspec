require 'spec_helper'

include Serverspec::Helper::Solaris

describe command('cat /etc/resolv.conf') do
  let(:stdout) { "nameserver 127.0.0.1\r\n" }
  it { should return_stdout("nameserver 127.0.0.1") }
  its(:command) { should eq 'cat /etc/resolv.conf' }
end

describe 'complete matching of stdout' do
  context command('cat /etc/resolv.conf') do
    let(:stdout) { "foocontent-should-be-includedbar\r\n" }
    it { should_not return_stdout('content-should-be-included') }
  end
end

describe 'regexp matching of stdout' do
  context command('cat /etc/resolv.conf') do
    let(:stdout) { "nameserver 127.0.0.1\r\n" }
    it { should return_stdout(/127\.0\.0\.1/) }
  end
end

describe command('cat /etc/resolv.conf') do
  let(:stdout) { "No such file or directory\r\n" }
  it { should return_stderr("No such file or directory") }
  its(:command) { should eq 'cat /etc/resolv.conf' }
end

describe 'complete matching of stderr' do
  context command('cat /etc/resolv.conf') do
    let(:stdout) { "No such file or directory\r\n" }
    it { should_not return_stdout('file') }
  end
end

describe 'regexp matching of stderr' do
  context command('cat /etc/resolv.conf') do
    let(:stdout) { "No such file or directory\r\n" }
    it { should return_stderr(/file/) }
  end
end

describe command('cat /etc/resolv.conf') do
  it { should return_exit_status 0 }
  its(:command) { should eq 'cat /etc/resolv.conf' }
end
