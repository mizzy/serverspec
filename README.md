# Serverspec [![Gem Version](https://badge.fury.io/rb/serverspec.svg)](http://badge.fury.io/rb/serverspec) [![BuildStatus](https://secure.travis-ci.org/mizzy/serverspec.svg)](http://travis-ci.org/mizzy/serverspec) [![wercker status](https://app.wercker.com/status/526d1ff4df6eadaa793dca1affcaed35/s/ "wercker status")](https://app.wercker.com/project/bykey/526d1ff4df6eadaa793dca1affcaed35)

RSpec tests for your servers configured by Puppet, Chef or anything else

You can see the details of serverspec on [serverspec.org](http://serverspec.org/).

----

## Running the gem's tests

Use

```bundle exec rake```

(Using ```rspec``` alone will not work).

## Regex matching
How do use a regex to check a cron entry? If that's not possible, is it possible to return all of the found cron entries and let me validate that the entry exists without using the have_entry matcher?

```
describe cron do
  it { should have_entry(%r{^\d{1,2} 0,6,12,18 * * * /bin/true$}).with_user('root') }
end
```

gives

```
Failures:

  1) Cron should have entry /^\d{1,2} 0,6,12,18 * * * \/bin\/true$/
     On host `infra-puppetca'
     Failure/Error: it { should have_entry(%r{^\d{1,2} 0,6,12,18 * * * /bin/true$}).with_user('root') }
     NoMethodError:
       undefined method `gsub' for /^\d{1,2} 0,6,12,18 * * * \/bin\/true$/:Regexp

     # /Users/gh/.rvm/gems/ruby-2.3.1/gems/specinfra-2.66.2/lib/specinfra/command/base/cron.rb:4:in `check_has_entry'
     # /Users/gh/.rvm/gems/ruby-2.3.1/gems/specinfra-2.66.2/lib/specinfra/command_factory.rb:18:in `get'
     # /Users/gh/.rvm/gems/ruby-2.3.1/gems/specinfra-2.66.2/lib/specinfra/runner.rb:26:in `run'
     # /Users/gh/.rvm/gems/ruby-2.3.1/gems/specinfra-2.66.2/lib/specinfra/runner.rb:13:in `method_missing'
     # /Users/gh/.rvm/gems/ruby-2.3.1/gems/serverspec-2.37.2/lib/serverspec/type/cron.rb:4:in `has_entry?'
     # /Users/gh/.rvm/gems/ruby-2.3.1/gems/serverspec-2.37.2/lib/serverspec/matcher/have_entry.rb:4:in `block (2 levels) in <top (required)>'
     # ./spec/infra-puppetca/sample_spec.rb:8:in `block (2 levels) in <top (required)>'
```

## Maintenance policy of Serverspec/Specinfra

* The person who found a bug should fix the bug by themself.
* If you find a bug and cannot fix it by yourself, send a pull request and attach test code to reproduce the bug, please.
* The person who want a new feature should implement it by themself.
* For above reasons, I accept pull requests only and disable issues.
* If you'd like to discuss about a new feature before implement it, make an empty commit and send [a WIP pull request](http://ben.straub.cc/2015/04/02/wip-pull-request/). But It is better that the WIP PR has some code than an empty commit.


----

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
