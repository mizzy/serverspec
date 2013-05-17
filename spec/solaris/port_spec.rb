require 'spec_helper'

include Serverspec::Helper::Solaris

describe 'Serverspec package matchers of Solaris family' do
  it_behaves_like 'support port listening matcher', 80
end
