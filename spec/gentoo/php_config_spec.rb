require 'spec_helper'

include Serverspec::Helper::Gentoo

describe 'Serverspec php_config matchers of Gentoo family' do
  it_behaves_like 'support php_config match_ini_value matcher', 'default_mimetype', 'text/html'
end

