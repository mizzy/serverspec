require 'spec_helper'

set :os, :family => 'base'

describe mysql_config('innodb-buffer-pool-size') do
  let(:stdout) { 'innodb-buffer-pool-size           134217728' }
  its(:value) { should eq 134217728 }
end

describe mysql_config('socket') do
  let(:stdout) { 'socket                            /tmp/mysql.sock' }
  its(:value) { should eq '/tmp/mysql.sock' }
end
