require 'spec_helper'

set :os, :family => 'base'

describe package('jekyll') do
  it { is_expected.to be_installed.by(:gem) }
end

describe package('jekyll') do
  it { is_expected.to be_installed.by(:gem).with_version('1.1.1') }
end

describe package('ruby') do
  it { is_expected.to be_installed.by(:rvm) }
end

describe package('ruby') do
  it { is_expected.to be_installed.by(:rvm).with_version('2.2.0') }
end

describe package('bower') do
  it { is_expected.to be_installed.by(:npm) }
end

describe package('bower') do
  it { is_expected.to be_installed.by(:npm).with_version('0.9.2') }
end

describe package('mongo') do
  it { is_expected.to be_installed.by(:pecl) }
end

describe package('mongo') do
  it { is_expected.to be_installed.by(:pecl).with_version('1.4.1') }
end

describe package('XML_Util') do
  it { is_expected.to be_installed.by(:pear).with_version('1.2.1') }
end

describe package('supervisor') do
  it { is_expected.to be_installed.by(:pip).with_version('3.0') }
end

describe package('App::Ack') do
  it { is_expected.to be_installed.by(:cpan) }
end

describe package('App::Ack') do
  it { is_expected.to be_installed.by(:cpan).with_version('2.04') }
end
