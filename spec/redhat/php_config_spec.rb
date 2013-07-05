require 'spec_helper'

include Serverspec::Helper::RedHat

describe 'Serverspec php_config matchers of Red Hat family' do
  it_behaves_like 'support explicit php_config checking with string', 'default_mimetype', 'text/html'
  it_behaves_like 'support explicit php_config checking with integer', 'session.cache_expire', 180
  it_behaves_like 'support explicit php_config checking with regexp',  'mbstring.http_output_conv_mimetypes', /application/
end

