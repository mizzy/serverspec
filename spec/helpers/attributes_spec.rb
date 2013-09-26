require 'spec_helper'

include Serverspec::Helper::Attributes

describe 'Attributes Helper' do
  before :all do
    attr_set :role => 'proxy'
  end
  subject { attr }
  it { should include :role => 'proxy' }
end
