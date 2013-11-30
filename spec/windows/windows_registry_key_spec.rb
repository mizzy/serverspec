require 'spec_helper'

include SpecInfra::Helper::Cmd
include SpecInfra::Helper::Windows

describe windows_registry_key('PATH/TO/THE_KEY') do
  it { should exist }
  its(:command) { should == "(Get-Item 'Registry::PATH/TO/THE_KEY') -ne $null" }
end

describe windows_registry_key('PATH/TO/THE_KEY') do
  it { should have_value('Test Value') }
  its(:command) { should == "(Compare-Object (Get-Item 'Registry::PATH/TO/THE_KEY').GetValue('') @('Test Value')) -eq $null" }
end

describe 'Key value types' do
  context 'default type' do
    describe windows_registry_key('PATH/TO/THE_KEY') do
      it { should have_property('TestProperty') }
      its(:command) { should == "(Get-Item 'Registry::PATH/TO/THE_KEY').GetValueKind('TestProperty') -eq 'String'" }
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
        it { should have_property('TestProperty', sym) }
        its(:command) { should == "(Get-Item 'Registry::PATH/TO/THE_KEY').GetValueKind('TestProperty') -eq '#{type}'" }
      end
    end
  end
end

describe windows_registry_key('PATH/TO/THE_KEY') do
  it { should have_property_value('TestProperty', :type_binary, '12a07b') }
  its(:command) { should == "(Compare-Object (Get-Item 'Registry::PATH/TO/THE_KEY').GetValue('TestProperty') ([byte[]] 18,160,123)) -eq $null" }
end

describe windows_registry_key('PATH/TO/THE_KEY') do
  it { should have_property_value('TestProperty', :type_dword, 'fffffd6c') }
  its(:command) { should == "(Compare-Object (Get-Item 'Registry::PATH/TO/THE_KEY').GetValue('TestProperty') -660) -eq $null" }
end

describe windows_registry_key('PATH/TO/THE_KEY') do
  it { should have_property_value('TestProperty', :type_qword, '1e240') }
  its(:command) { should == "(Compare-Object (Get-Item 'Registry::PATH/TO/THE_KEY').GetValue('TestProperty') 123456) -eq $null" }
end

describe windows_registry_key('PATH/TO/THE_KEY') do
  it {
    value = <<-EOF
test line1
test line2
test line3
EOF
    should have_property_value('TestProperty', :type_multistring, value)
  }
  its(:command) { should == "(Compare-Object (Get-Item 'Registry::PATH/TO/THE_KEY').GetValue('TestProperty') @('test line1','test line2','test line3')) -eq $null" }
end
