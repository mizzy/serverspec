require 'spec_helper'

include Specinfra::Helper::Cmd

set :os, :family => 'windows'

describe windows_feature('Minesweeper') do
  it{ should be_installed }
end
