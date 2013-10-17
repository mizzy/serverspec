## Windows support

Serverspec is now providing a limited support for Microsoft Windows.

If you want to test Windows based machines you need to set the target host's OS explicitly in your `spec/spec_helper.rb`

For local testing (equivalent to the Exec option in Linux/Unix systems) simply do:

```ruby
require 'serverspec'

include Serverspec::Helper::Cmd
include Serverspec::Helper::Windows

```

For remote testing you have to configure Windows Remote Management in order to communicate to the target host:

```ruby
require 'serverspec'
require 'winrm'

include Serverspec::Helper::WinRM
include Serverspec::Helper::Windows

RSpec.configure do |c|
  user = <username>
  pass = <password>
  endpoint = "http://<hostname>:5985/wsman"
  
  c.winrm = ::WinRM::WinRMWebService.new(endpoint, :ssl, :user => user, :pass => pass, :basic_auth_only => true)
  c.winrm.set_timeout 300 # 5 minutes max timeout for any operation
end
```

For how to configure the guest to accept WinRM connections and the different authentication mechanisms check the Microsoft WinRM documentation and verify the ones that are supported by [WinRb/WinRM](https://github.com/WinRb/WinRM).


###RSpec Examples for windows target hosts
```ruby
describe file('c:/windows') do
  it { should be_directory }
  it { should be_readable }
  it { should_not be_writable.by('Everyone') }
end

describe file('c:/temp/test.txt') do
  it { should be_file }
  it { should contain "some text" }
end

describe package('Adobe AIR') do
  it { should be_installed}
end

describe service('DNS Client') do
  it { should be_enabled }
  it { should be_running }
end

describe port(139) do
  it { should be_listening }
end

describe user('some.admin') do
  it { should exist }
  it { should belong_to_group('Administrators')}
end

describe group('Guests') do
  it { should exist }
end

describe group('MYDOMAIN\Domain Users') do
  it { should exist }
end

describe command('& "ipconfig"') do
  it { should return_stdout(/IPv4 Address(\.| )*: 192\.168\.1\.100/) }
end

describe windows_registry_key('HKEY_USERS\S-1-5-21-1319311448-2088773778-316617838-32407\Test MyKey') do
  it { should exist }
  it { should have_property('string value') }
  it { should have_property('binary value', :type_binary) }
  it { should have_property('dword value', :type_dword) }
  it { should have_value('test default data') }
  it { should have_property_value('multistring value', :type_multistring, "test\nmulti\nstring\ndata") }
  it { should have_property_value('qword value', :type_qword, 'adff32') }
  it { should have_property_value('binary value', :type_binary, 'dfa0f066') }
end
```

###Notes:
* Not all the matchers you are used to in Linux-like OS are supported in Windows, some because of differences between the operating systems (e.g. users and permissions model), some because they haven't been yet implemented.
* All commands in the windows backend are run via powershell, so the output in case of stderr is a pretty ugly xml-like thing. Still it should contain some information to help troubleshooting.
* The *command* type is executed again through powershell, so bear that in mind if you mean to run old CMD windows batch or programs. (i.e run the command using the **Invoke-Expression** Cmdlet, or the **&** Call Operator)