require 'spec_helper'

set :backend, :cmd
set :os, :family => 'windows'

describe windows_registry_key('PATH/TO/THE_KEY') do
  it { is_expected.to exist }
end

describe windows_registry_key('PATH/TO/THE_KEY') do
  it { is_expected.to have_value('Test Value') }
end

describe 'Key value types' do
  context 'default type' do
    describe windows_registry_key('PATH/TO/THE_KEY') do
      it { is_expected.to have_property('TestProperty') }
    end
  end

  {
    :type_string       => 'String',
    :type_binary       => 'Binary',
    :type_dword        => 'DWord',
    :type_qword        => 'QWord',
    :type_multistring  => 'MultiString',
    :type_expandstring => 'ExpandString'
  }.each do |sym, type|
    context "type #{type}" do
      describe windows_registry_key('PATH/TO/THE_KEY') do
        it { is_expected.to have_property('TestProperty', sym) }
      end
    end
  end
end

describe windows_registry_key('PATH/TO/THE_KEY') do
  it { is_expected.to have_property_value('TestProperty', :type_binary, '12a07b') }
end

describe windows_registry_key('PATH/TO/THE_KEY') do
  it { is_expected.to have_property_value('TestProperty', :type_dword, 'fffffd6c') }
end

describe windows_registry_key('PATH/TO/THE_KEY') do
  it { is_expected.to have_property_value('TestProperty', :type_qword, '1e240') }
end

describe windows_registry_key('PATH/TO/THE_KEY') do
  it {
    value = <<-EOF
test line1
test line2
test line3
EOF
    is_expected.to have_property_value('TestProperty', :type_multistring, value)
  }
end
