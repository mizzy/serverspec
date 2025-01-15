require 'spec_helper'

describe String do
  subject { String.new }
  it { is_expected.to_not respond_to :host }
end
