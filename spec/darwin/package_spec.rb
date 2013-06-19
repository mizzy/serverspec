require 'spec_helper'

include Serverspec::Helper::Darwin

describe 'Serverspec package matchers of Darwin family' do
  it_behaves_like 'support package installed by gem matcher', 'jekyll'
  it_behaves_like 'support package installed by gem with version matcher', 'jekyll', '1.1.1'
  it_behaves_like 'support package installed by npm matcher', 'bower'
  it_behaves_like 'support package installed by npm with version matcher', 'bower', '0.9.2'
  it_behaves_like 'support package installed by pecl matcher', 'mongo'
  it_behaves_like 'support package installed by pecl with version matcher', 'mongo', '1.4.1'
end
