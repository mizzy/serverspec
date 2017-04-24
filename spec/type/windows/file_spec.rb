require 'spec_helper'

set :backend, :cmd

set :os, :family => 'windows'

describe file('/some/valid/file') do
  it { should be_file }
end

describe file('/some/valid/folder') do
  it { should be_directory }
end

describe file('/some/file') do
  it { should contain 'search text' }
end

describe file('/some/file') do
  it { should contain /^search text/ }
end

describe file('Gemfile') do
  it { should contain('rspec').from(/^group :test do/).to(/^end/) }
end

describe file('Gemfile') do
  it { should contain('rspec').after(/^group :test do/) }
end

describe file('Gemfile') do
  it { should contain('rspec').before(/end/) }
end

describe file('/some/file') do
  it { should be_readable }
end

describe file('/some/file') do
  it "should raise error if trying to check access by 'owner' or 'group' or 'others'" do
   ['owner', 'group', 'others'].each do |access|
     expect { should be_readable.by(access) }.to raise_error(RuntimeError)
   end
 end
end

describe file('/some/file') do
  it { should be_readable.by('test.identity') }
end

describe file('/some/file') do
  it { should be_readable.by_user('test.identity') }
end

describe file('/some/file') do
  it { should be_writable }
end

describe file('/some/file') do
  it "should raise error if trying to check access by 'owner' or 'group' or 'others'" do
   ['owner', 'group', 'others'].each do |access|
     expect { should be_writable.by(access) }.to raise_error(RuntimeError)
   end
 end
end

describe file('/some/file') do
  it { should be_writable.by('test.identity') }
end

describe file('/some/file') do
  it { should be_writable.by_user('test.identity') }
end

describe file('/some/file') do
  it { should be_executable }
end

describe file('/some/file') do
  it "should raise error if trying to check access by 'owner' or 'group' or 'others'" do
   ['owner', 'group', 'others'].each do |access|
     expect { should be_executable.by(access) }.to raise_error(RuntimeError)
   end
 end
end

describe file('/some/file') do
  it { should be_executable.by('test.identity') }
end

describe file('/some/file') do
  it { should be_executable.by_user('test.identity') }
end

describe file('/some/file') do
  it { should be_version 1 }
end

describe file('/some/test/file') do
  it "should raise error if command is not implemented" do
    {
      :be_socket => [],
      :be_mode => 644,
      :be_grouped_into => 'root',
      :be_linked_to => '/some/other/file',
      :be_mounted => []
    }.each do |method, args|
      expect { should self.send(method, *args) }.to raise_error(NotImplementedError)
    end
  end

  it "should raise error if command is not defined" do
    {
      :match_md5checksum => '35435ea447c19f0ea5ef971837ab9ced',
      :match_sha256checksum => '0c3feee1353a8459f8c7d84885e6bc602ef853751ffdbce3e3b6dfa1d345fc7a'
    }.each do |method, args|
      expect { should self.send(method, *args) }.to raise_error(NoMethodError)
    end
  end
end







