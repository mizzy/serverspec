# Serverspec

RSpec tests for your provisioned servers

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
 + spec/
 + spec/www.example.jp/
 + spec/spec_helper.rb
 + Rakefile
 + spec/www.example.jp/httpd_spec.rb
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

You can write spec for testing provisioned servers like this.

You should create ~/.ssh/config like this before running tests.

```
Host *.example.jp
   User root
   IdentityFile ~/.ssh/id_rsa
```

Run tests.

```
$ rake spec
```

----

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
