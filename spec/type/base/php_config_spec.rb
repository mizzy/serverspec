require 'spec_helper'

set :os, :family => 'base'

describe php_config('default_mimetype') do
  let(:stdout) { 'text/html' }
  its(:value) { should eq 'text/html' }
end

describe php_config('default_mimetype') do
  let(:stdout) { 'text/html' }
  its(:value) { should_not eq 'text/plain' }
end

describe php_config('session.cache_expire') do
  let(:stdout) { '180' }
  its(:value) { should eq 180 }
end

describe php_config('session.cache_expire') do
  let(:stdout) { '180' }
  its(:value) { should_not eq 360 }
end

describe php_config('mbstring.http_output_conv_mimetypes') do
  let(:stdout) { 'application' }
  its(:value) { should match /application/ }
end

describe php_config('mbstring.http_output_conv_mimetypes') do
  let(:stdout) { 'application' }
  its(:value) { should_not match /html/ }
end
describe php_config('default_mimetype', :ini => '/etc/php5/php.ini') do
  let(:stdout) { 'text/html' }
  its(:value) { should eq 'text/html' }
end
