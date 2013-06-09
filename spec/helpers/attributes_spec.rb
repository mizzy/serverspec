require 'spec_helper'
require 'serverspec/helper/base'

include Serverspec::Helper::Base
include Serverspec::Helper::Attributes

describe 'Attributes Helper' do
  before :all do
    attr_set :role => 'proxy'
  end
  subject { attr }
  it { should include :role => 'proxy' }
end
