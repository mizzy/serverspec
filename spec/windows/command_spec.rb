require 'spec_helper'

include Serverspec::Helper::Cmd
RSpec.configure do |c|
  c.os = 'Windows'
end

describe command('test_cmd /test/path/file') do
  let(:stdout) { "test output 1.2.3\r\n" }
  it { should return_stdout("test output 1.2.3") }
  its(:command) { should eq 'test_cmd /test/path/file' }
end

describe 'complete matching of stdout' do
  context command('test_cmd /test/path/file') do
    let(:stdout) { "foocontent-should-be-includedbar\r\n" }
    it { should_not return_stdout('content-should-be-included') }
  end
end

describe 'regexp matching of stdout' do
  context command('test_cmd /test/path/file') do
    let(:stdout) { "test output 1.2.3\r\n" }
    it { should return_stdout(/1\.2\.3/) }
  end
end

describe command('test_cmd /test/path/file') do
  let(:stdout) { "No such file or directory\r\n" }
  it { should return_stderr("No such file or directory") }
  its(:command) { should eq 'test_cmd /test/path/file' }
end

describe 'complete matching of stderr' do
  context command('test_cmd /test/path/file') do
    let(:stdout) { "No such file or directory\r\n" }
    it { should_not return_stdout('file') }
  end
end

describe 'regexp matching of stderr' do
  context command('test_cmd /test/path/file') do
    let(:stdout) { "No such file or directory\r\n" }
    it { should return_stderr(/file/) }
  end
end

describe command('test_cmd /test/path/file') do
  it { should return_exit_status 0 }
  its(:command) { should eq 'test_cmd /test/path/file' }
end
