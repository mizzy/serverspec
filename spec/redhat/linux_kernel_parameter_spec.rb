require 'spec_helper'

include Serverspec::Helper::RedHat

describe 'Serverspec linux kernel parameter matchers of Red Hat family' do
  it_behaves_like 'support explicit linux kernel parameter checking with integer', 'net.ipv4.tcp_syncookies', 1
  it_behaves_like 'support explicit linux kernel parameter checking with string',  'kernel.osrelease', '2.6.32-131.0.15.el6.x86_64'
  it_behaves_like 'support explicit linux kernel parameter checking with regexp',  'net.ipv4.tcp_wmem', /4096\t16384\t4194304/
end
