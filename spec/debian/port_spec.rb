require 'spec_helper'

include Serverspec::Helper::Debian

describe 'Serverspec port matchers of Debian family' do
  it_behaves_like 'support port listening matcher', 80
end
