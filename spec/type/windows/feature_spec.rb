require 'spec_helper'

include Specinfra::Helper::Cmd

set :os, :family => 'windows'

describe commands.command_class('feature').create do
  it { should be_an_instance_of(Specinfra::Command::Windows::Base::Feature) }
end

describe windows_feature('Minesweeper') do
  it{ should be_installed }
end
