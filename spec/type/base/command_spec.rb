require 'spec_helper'

set :os, :family => 'base'

describe command('cat /etc/resolv.conf') do
  let(:stdout) { "nameserver 127.0.0.1\r\n" }
  its(:stdout) { should match /nameserver 127.0.0.1/ }
end

describe 'complete matching of stdout' do
  context command('cat /etc/resolv.conf') do
    let(:stdout) { "foocontent-should-be-includedbar\r\n" }
    its(:stdout) { should_not eq 'content-should-be-included' }
  end
end

describe 'regexp matching of stdout' do
  context command('cat /etc/resolv.conf') do
    let(:stdout) { "nameserver 127.0.0.1\r\n" }
    its(:stdout) { should match /127\.0\.0\.1/ }
  end
end

describe command('cat /etc/resolv.conf') do
  let(:stderr) { "No such file or directory\r\n" }
  its(:stderr) { should match /No such file or directory/ }
end

describe 'complete matching of stderr' do
  context command('cat /etc/resolv.conf') do
    let(:stderr) { "No such file or directory\r\n" }
    its(:stdout) { should_not eq 'file' }
  end
end

describe 'regexp matching of stderr' do
  context command('cat /etc/resolv.conf') do
    let(:stderr) { "No such file or directory\r\n" }
    its(:stderr) { should match /file/ }
  end
end

describe command('cat /etc/resolv.conf') do
  its(:exit_status) { should eq 0 }
end

describe command('ls -al /') do
 let(:stdout) { <<EOF
total 88
drwxr-xr-x  23 root root  4096 Oct 10 17:19 .
drwxr-xr-x  23 root root  4096 Oct 10 17:19 ..
drwxr-xr-x   2 root root  4096 Sep 11 16:43 bin
drwxr-xr-x   3 root root  4096 Sep 23 18:14 boot
drwxr-xr-x  14 root root  4260 Oct 14 16:14 dev
drwxr-xr-x 104 root root  4096 Oct 14 17:34 etc
drwxr-xr-x   8 root root  4096 Oct  1 15:09 home
EOF
    }

  its(:stdout) { should match /bin/ }
  its(:stdout) { should eq stdout }
  its(:stdout) { should contain('4260') }
  its(:stdout) { should contain('4260').from('bin').to('home') }
  its(:stdout) { should contain('4260').after('bin') }
  its(:stdout) { should contain('4260').before('home') }
  its(:stdout) { should_not contain('4260').before('bin') }
end
