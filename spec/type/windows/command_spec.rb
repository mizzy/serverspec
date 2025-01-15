require 'spec_helper'

set :backend, :cmd
set :os, :family => 'windows'

describe command('test_cmd /test/path/file') do
  let(:stdout) { "test output 1.2.3\r\n" }
  its(:stdout) { is_expected.to match /test output 1.2.3/ }
end

describe 'complete matching of stdout' do
  context command('test_cmd /test/path/file') do
    let(:stdout) { "foocontent-should-be-includedbar\r\n" }
    its(:stdout) { is_expected.to_not eq 'content-should-be-included' }
  end
end

describe 'regexp matching of stdout' do
  context command('test_cmd /test/path/file') do
    let(:stdout) { "test output 1.2.3\r\n" }
    its(:stdout) { is_expected.to match /1\.2\.3/ }
  end
end

describe command('test_cmd /test/path/file') do
  let(:stderr) { "No such file or directory\r\n" }
  its(:stderr) { is_expected.to match /No such file or directory/ }
end

describe 'complete matching of stderr' do
  context command('test_cmd /test/path/file') do
    let(:stderr) { "No such file or directory\r\n" }
    its(:stderr) { is_expected.to_not eq 'file' }
  end
end

describe 'regexp matching of stderr' do
  context command('test_cmd /test/path/file') do
    let(:stderr) { "No such file or directory\r\n" }
    its(:stderr) { is_expected.to match /file/ }
  end
end

describe command('test_cmd /test/path/file') do
  its(:exit_status) { is_expected.to eq 0 }
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

  its(:stdout) { is_expected.to match /Program Files/ }
  its(:stdout) { is_expected.to eq stdout }
end
