require 'spec_helper'

set :os, :family => 'aix'

describe group('root') do
  it 'have_gid is not implemented' do
    expect {
      should have_gid 0
    }.to raise_exception(NotImplementedError)
  end
end
