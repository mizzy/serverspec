# Serverspec [![BuildStatus](https://secure.travis-ci.org/mizzy/serverspec.png)](http://travis-ci.org/mizzy/serverspec)

RSpec tests for your servers provisioned by Puppet, Chef or anything else

You can see the details of serverspec on [serverspec.org](http://serverspec.org/).

----

## Installation

Add this line to your application's Gemfile:

    gem 'serverspec'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install serverspec

----

## Usage

```
$ serverspec-init
Select a backend type:

  1) SSH
  2) Exec (local)

Select number: 1

Input target host name: www.example.jp

Select OS type of target host:

  1) Auto Detect
  2) Red Hat
  3) Debian
  4) Gentoo
  5) Solaris

Select number: 1

 + spec/
 + spec/www.example.jp/
 + spec/www.example.jp/httpd_spec.rb
 + spec/spec_helper.rb
 + Rakefile
```

spec/www.example.jp/httpd_spec.rb is a sample spec file and its content is like this.

```ruby
require 'spec_helper'

describe 'httpd' do
  it { should be_installed }
  it { should be_enabled   }
  it { should be_running   }
end

describe 'port 80' do
  it { should be_listening }
end

describe '/etc/httpd/conf/httpd.conf' do
  it { should be_file }
  it { should contain "ServerName www.example.jp" }
end
```

You can write spec for testing servers like this.

You should create ~/.ssh/config like this before running tests because serverspec tests servers through SSH access.

```
Host *.example.jp
   User root
   IdentityFile ~/.ssh/id_rsa
   StrictHostKeyChecking no
   UserKnownHostsFile /dev/null
```

Run tests.

```
$ rake spec
/usr/bin/ruby -S rspec spec/www.example.jp/httpd_spec.rb
......

Finished in 0.99715 seconds
6 examples, 0 failures
```

----
## Multi OS support

Serverspec is supporting Red Hat based OS, Debian based OS, Gentoo and Solaris.

Serverspec can detect target host's OS automatically.

If you'd like to set target host's OS explicitly, you should include `Serverspec::Helper::OSName` like this.


```ruby
require 'serverspec'
require 'pathname'
require 'net/ssh'

RSpec.configure do |c|
  # Include backend helper
  c.include(Serverspec::Helper::Ssh)
  # Include OS helper
  c.include(Serverspec::Helper::Debian)
  # Add SSH before hook in case you use the SSH backend
  # (not required for the Exec backend)
  c.before do
    host  = File.basename(Pathname.new(example.metadata[:location]).dirname)
    if c.host != host
      c.ssh.close if c.ssh
      c.host  = host
      options = Net::SSH::Config.for(c.host)
      user    = options[:user] || Etc.getlogin
      c.ssh   = Net::SSH.start(c.host, user, options)
    end
  end
end
```

See details on [serverspec.org](http://serverspec.org)

----

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
