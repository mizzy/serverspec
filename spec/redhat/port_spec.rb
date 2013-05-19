require 'spec_helper'

include Serverspec::Helper::RedHat

describe 'Serverspec port matchers of Red Hat family' do
  it_behaves_like 'support port listening matcher', 80
end
