# Serverspec

[![CI](https://github.com/mizzy/serverspec/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/mizzy/serverspec/actions/workflows/ci.yml) [![Gem Version](https://img.shields.io/gem/v/serverspec.svg)](https://rubygems.org/gems/serverspec) [![Downloads](https://img.shields.io/gem/dt/serverspec.svg)](https://rubygems.org/gems/serverspec) [![License](https://img.shields.io/github/license/mizzy/serverspec.svg)](https://github.com/mizzy/serverspec/blob/master/LICENSE.txt)

RSpec tests for your servers configured by Puppet, Chef or anything else

You can see the details of serverspec on [serverspec.org](http://serverspec.org/).

----

## Running the gem's tests

Use

```bundle exec rake```

(Using ```rspec``` alone will not work).



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
