require 'spec_helper'

include SpecInfra::Helper::Solaris10

describe php_config('default_mimetype') do
  let(:stdout) { 'text/html' }
  its(:value) { should eq 'text/html' }
  its(:command) { should eq "php -r 'echo get_cfg_var( \"default_mimetype\" );'" }
end

describe php_config('default_mimetype') do
  let(:stdout) { 'text/html' }
  its(:value) { should_not eq 'text/plain' }
end

describe php_config('session.cache_expire') do
  let(:stdout) { '180' }
  its(:value) { should eq 180 }
  its(:command) { should eq "php -r 'echo get_cfg_var( \"session.cache_expire\" );'" }
end

describe php_config('session.cache_expire') do
  let(:stdout) { '180' }
  its(:value) { should_not eq 360 }
end

describe php_config('mbstring.http_output_conv_mimetypes') do
  let(:stdout) { 'application' }
  its(:value) { should match /application/ }
  its(:command) { should eq "php -r 'echo get_cfg_var( \"mbstring.http_output_conv_mimetypes\" );'" }
end

describe php_config('mbstring.http_output_conv_mimetypes') do
  let(:stdout) { 'application' }
  its(:value) { should_not match /html/ }
end
