require 'spec_helper'

include Serverspec::Helper::Solaris

describe zfs('rpool') do
  it { should exist }
  it { should have_property 'mountpoint' => '/rpool'  }
  it { should have_property 'mountpoint' => '/rpool', 'compression' => 'off' }
end
