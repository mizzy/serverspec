require 'spec_helper'

include SpecInfra::Helper::Cmd
include SpecInfra::Helper::Windows

describe file('/some/valid/file') do
  it { should be_file }
  its(:command) { should == "((Get-Item -Path '/some/valid/file' -Force).attributes.ToString() -Split ', ') -contains 'Archive'" }
end

describe file('/some/invalid/file') do
  it { should_not be_file }
end

describe file('/some/valid/folder') do
  it { should be_directory }
  its(:command) { should == "((Get-Item -Path '/some/valid/folder' -Force).attributes.ToString() -Split ', ') -contains 'Directory'" }
end

describe file('/some/invalid/folder') do
  it { should_not be_directory }
end

describe file('/some/file') do
  it { should contain 'search text' }
  its(:command) { should == "[Io.File]::ReadAllText('/some/file') -match 'search text'" }
end

describe file('/some/file') do
  it { should contain /^search text/ }
  its(:command) { should == "[Io.File]::ReadAllText('/some/file') -match '^search text'" }
end

describe file('/some/file') do
  it { should_not contain 'This is invalid text!!' }
end

describe file('Gemfile') do
  it { should contain('rspec').from(/^group :test do/).to(/^end/) }
  its(:command) { should == "(CropText -text ([Io.File]::ReadAllText('Gemfile')) -fromPattern '^group :test do' -toPattern '^end') -match 'rspec'" }
end

describe file('/some/file') do
  it { should_not contain('This is invalid text!!').from(/^group :test do/).to(/^end/) }
end

describe file('Gemfile') do
  it { should contain('rspec').after(/^group :test do/) }
  its(:command) { should == "(CropText -text ([Io.File]::ReadAllText('Gemfile')) -fromPattern '^group :test do' -toPattern '$') -match 'rspec'" }
end

describe file('Gemfile') do
  it { should_not contain('This is invalid text!!').after(/^group :test do/) }
end

describe file('Gemfile') do
  it { should contain('rspec').before(/end/) }
  its(:command) { should == "(CropText -text ([Io.File]::ReadAllText('Gemfile')) -fromPattern '^' -toPattern 'end') -match 'rspec'" }
end

describe file('Gemfile') do
  it { should_not contain('This is invalid text!!').before(/^end/) }
end

describe file('/some/file') do
  it { should be_readable }
  its(:command) { should eq "CheckFileAccessRules -path '/some/file' -identity 'Everyone' -rules @('FullControl', 'Modify', 'ReadAndExecute', 'Read', 'ListDirectory')" }
end

describe file('/some/invalid/file') do
  it { should_not be_readable }
end

describe file('/some/file') do
  it "should raise error if trying to check access by 'owner' or 'group' or 'others'" do
   ['owner', 'group', 'others'].each do |access|
     expect { should be_readable.by(access) }.to raise_error
   end
 end
end

describe file('/some/file') do
  it { should be_readable.by('test.identity') }
  its(:command) { should eq "CheckFileAccessRules -path '/some/file' -identity 'test.identity' -rules @('FullControl', 'Modify', 'ReadAndExecute', 'Read', 'ListDirectory')" }
end

describe file('/some/file') do
  it { should be_readable.by_user('test.identity') }
  its(:command) { should eq "CheckFileAccessRules -path '/some/file' -identity 'test.identity' -rules @('FullControl', 'Modify', 'ReadAndExecute', 'Read', 'ListDirectory')" }
end

describe file('/some/file') do
  it { should be_writable }
  its(:command) { should eq "CheckFileAccessRules -path '/some/file' -identity 'Everyone' -rules @('FullControl', 'Modify', 'Write')" }
end

describe file('/some/invalid/file') do
  it { should_not be_writable }
end

describe file('/some/file') do
  it "should raise error if trying to check access by 'owner' or 'group' or 'others'" do
   ['owner', 'group', 'others'].each do |access|
     expect { should be_writable.by(access) }.to raise_error
   end
 end
end

describe file('/some/file') do
  it { should be_writable.by('test.identity') }
  its(:command) { should eq "CheckFileAccessRules -path '/some/file' -identity 'test.identity' -rules @('FullControl', 'Modify', 'Write')" }
end

describe file('/some/file') do
  it { should be_writable.by_user('test.identity') }
  its(:command) { should eq "CheckFileAccessRules -path '/some/file' -identity 'test.identity' -rules @('FullControl', 'Modify', 'Write')" }
end

describe file('/some/file') do
  it { should be_executable }
  its(:command) { should eq "CheckFileAccessRules -path '/some/file' -identity 'Everyone' -rules @('FullControl', 'Modify', 'ReadAndExecute', 'ExecuteFile')" }
end

describe file('/some/invalid/file') do
  it { should_not be_executable }
end

describe file('/some/file') do
  it "should raise error if trying to check access by 'owner' or 'group' or 'others'" do
   ['owner', 'group', 'others'].each do |access|
     expect { should be_executable.by(access) }.to raise_error
   end
 end
end

describe file('/some/file') do
  it { should be_executable.by('test.identity') }
  its(:command) { should eq "CheckFileAccessRules -path '/some/file' -identity 'test.identity' -rules @('FullControl', 'Modify', 'ReadAndExecute', 'ExecuteFile')" }
end

describe file('/some/file') do
  it { should be_executable.by_user('test.identity') }
  its(:command) { should eq "CheckFileAccessRules -path '/some/file' -identity 'test.identity' -rules @('FullControl', 'Modify', 'ReadAndExecute', 'ExecuteFile')" }
end

describe file('/some/test/file') do
  it "should raise error if command is not supported" do 
    {
      :be_socket => [],
      :be_mode => 644,
      :be_owned_by => 'root',
      :be_grouped_into => 'root',
      :be_linked_to => '/some/other/file',
      :be_mounted => [],
      :match_md5checksum => '35435ea447c19f0ea5ef971837ab9ced',
      :match_sha256checksum => '0c3feee1353a8459f8c7d84885e6bc602ef853751ffdbce3e3b6dfa1d345fc7a'
    }.each do |method, args|
      expect { should self.send(method, *args) }.to raise_error SpecInfra::Command::Windows::NotSupportedError
    end
  end
end
