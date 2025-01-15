require 'spec_helper'

set :os, :family => 'base'

describe php_config('default_mimetype') do
  let(:stdout) { 'text/html' }
  its(:value) { is_expected.to eq 'text/html' }
end

describe php_config('default_mimetype') do
  let(:stdout) { 'text/html' }
  its(:value) { is_expected.to_not eq 'text/plain' }
end

describe php_config('session.cache_expire') do
  let(:stdout) { '180' }
  its(:value) { is_expected.to eq 180 }
end

describe php_config('session.cache_expire') do
  let(:stdout) { '180' }
  its(:value) { is_expected.to_not eq 360 }
end

describe php_config('mbstring.http_output_conv_mimetypes') do
  let(:stdout) { 'application' }
  its(:value) { is_expected.to match /application/ }
end

describe php_config('mbstring.http_output_conv_mimetypes') do
  let(:stdout) { 'application' }
  its(:value) { is_expected.to_not match /html/ }
end
describe php_config('default_mimetype', :ini => '/etc/php5/php.ini') do
  let(:stdout) { 'text/html' }
  its(:value) { is_expected.to eq 'text/html' }
end
