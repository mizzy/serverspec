require 'spec_helper'

set :backend, :cmd

set :os, :family => 'windows'

describe windows_feature('Minesweeper') do
  it{ should be_installed }
end
