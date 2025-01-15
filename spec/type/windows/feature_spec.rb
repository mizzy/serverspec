require 'spec_helper'

set :backend, :cmd

set :os, :family => 'windows'

describe windows_feature('Minesweeper') do
  it{ is_expected.to be_installed }
end

describe windows_feature('IIS-Webserver') do
  it{ is_expected.to be_installed.by(:dism) }
end

describe windows_feature('Web-Webserver') do
  it{ is_expected.to be_installed.by(:powershell) }
end
