require 'spec_helper'

include SpecInfra::Helper::Debian

describe mysql('localhost') do
  it { should be_accessible }
  its(:command) { should eq "mysql -e 'SHOW DATABASES;' -h localhost" }
end

describe mysql('localhost') do
  it { should be_accessible.with_user('root') }
  its(:command) { should eq "mysql -e 'SHOW DATABASES;' -h localhost -u root" }
end

describe mysql('localhost') do
  it { should be_accessible.with_password('password') }
  its(:command) { should eq "mysql -e 'SHOW DATABASES;' -h localhost --password=password" }
end

describe mysql('localhost') do
  it { should be_accessible.with_database('test') }
  its(:command) { should eq "mysql -e 'SHOW DATABASES;' -h localhost test" }
end

describe mysql('localhost') do
  it { should be_accessible.with_user('root').with_password('password').with_database('test') }
  its(:command) { should eq "mysql -e 'SHOW DATABASES;' -h localhost -u root --password=password test" }
end
