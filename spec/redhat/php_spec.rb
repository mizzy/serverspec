require 'spec_helper'

include Serverspec::Helper::RedHat

describe 'Serverspec php matchers of Red Hat family' do
  it_behaves_like 'support php match_ini_value matcher', 'default_mimetype', 'text/html'
end

