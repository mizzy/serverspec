require 'spec_helper'

include SpecInfra::Helper::Cmd
include SpecInfra::Helper::Windows

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
  let(:stderr) { "No such file or directory\r\n" }
  it { should return_stderr("No such file or directory") }
  its(:command) { should eq 'test_cmd /test/path/file' }
end

describe 'complete matching of stderr' do
  context command('test_cmd /test/path/file') do
    let(:stderr) { "No such file or directory\r\n" }
    it { should_not return_stderr('file') }
  end
end

describe 'regexp matching of stderr' do
  context command('test_cmd /test/path/file') do
    let(:stderr) { "No such file or directory\r\n" }
    it { should return_stderr(/file/) }
  end
end

describe command('test_cmd /test/path/file') do
  it { should return_exit_status 0 }
  its(:command) { should eq 'test_cmd /test/path/file' }
end

describe command('dir "c:\"') do
  let(:stdout) { <<EOF
    Directory: C:\

Mode                LastWriteTime     Length Name
----                -------------     ------ ----
d-r--        23/09/2013  10:46 AM            Program Files
d-r--        23/09/2013   1:21 PM            Program Files (x86)
d----        17/10/2013   8:46 PM            temp
d-r--        23/09/2013  11:52 AM            Users
d----        23/09/2013   1:21 PM            Windows
EOF
    }

  its(:stdout) { should match /Program Files/ }
  its(:stdout) { should eq stdout }
end
