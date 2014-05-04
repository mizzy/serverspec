require 'spec_helper'

describe String do
  subject { String.new }
  it { should_not respond_to :host }
end
