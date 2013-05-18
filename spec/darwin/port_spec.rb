require 'spec_helper'

include Serverspec::Helper::Darwin

describe 'Serverspec port matchers of Darwin family' do
  it_behaves_like 'support port listening matcher', 80
end
