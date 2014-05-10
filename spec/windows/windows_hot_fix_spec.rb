require 'spec_helper'

include SpecInfra::Helper::Cmd
include SpecInfra::Helper::Windows

describe windows_hot_fix('DESCRIPTION-OR-KB-ID') do
  it { should be_installed }
  its(:command) { should == "(FindInstalledHotFix -description 'DESCRIPTION-OR-KB-ID' -hotFixId 'DESCRIPTION-OR-KB-ID') -eq $true" }
end

describe windows_hot_fix('DESCRIPTION') do
  it { should be_installed.with_version('KB-ID') }
  its(:command) { should == "(FindInstalledHotFix -description 'DESCRIPTION' -hotFixId 'KB-ID') -eq $true" }
end

describe windows_hot_fix('DESCRIPTION_WITH_KB123456789_INLINED') do
  it { should be_installed }
  its(:command) { should == "(FindInstalledHotFix -description 'DESCRIPTION_WITH_KB123456789_INLINED' -hotFixId 'KB123456789') -eq $true" }
end

describe windows_hot_fix('DESCRIPTION_WITH_SUFFIX_KB123456789') do
  it { should be_installed }
  its(:command) { should == "(FindInstalledHotFix -description 'DESCRIPTION_WITH_SUFFIX_KB123456789' -hotFixId 'KB123456789') -eq $true" }
end

