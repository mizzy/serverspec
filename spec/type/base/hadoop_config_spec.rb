require 'spec_helper'

set :os, :family => 'base'

describe 'check /etc/hadoop/conf/hdfs-site.xml' do
  context hadoop_config('dfs.nameservices') do
    its(:value) { should eq 'hdfs-cluster' }
  end
  context hadoop_config('dfs.client.context') do
    its(:value) { should eq 'false' }
  end
end
describe 'check /etc/hadoop/conf/mapred-site.xml' do
  context hadoop_config('mapreduce.jobtracker.address') do
    its(:value) { should eq 'local' }
  end
  context hadoop_config('mapreduce.job.maps	') do
    its(:value) { should eq '2' }
  end
end
