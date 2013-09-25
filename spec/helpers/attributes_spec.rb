require 'spec_helper'

include Serverspec::Helper::Attributes

RSpec.configure do |c|
  c.backend = 'Exec'
end

describe 'Attributes Helper' do
  before :all do
    attr_set :role => 'proxy'
  end
  subject { attr }
  it { should include :role => 'proxy' }
end
