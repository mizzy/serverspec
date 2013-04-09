# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "serverspec"
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gosuke Miyashita"]
  s.date = "2013-04-09"
  s.description = "RSpec tests for your servers provisioned by Puppet, Chef or anything else"
  s.email = ["gosukenator@gmail.com"]
  s.executables = ["serverspec-init"]
  s.files = [".gitignore", ".travis.yml", "Gemfile", "LICENSE.txt", "README.md", "Rakefile", "bin/serverspec-init", "lib/serverspec.rb", "lib/serverspec/backend.rb", "lib/serverspec/backend/exec.rb", "lib/serverspec/backend/puppet.rb", "lib/serverspec/backend/ssh.rb", "lib/serverspec/commands/base.rb", "lib/serverspec/commands/debian.rb", "lib/serverspec/commands/gentoo.rb", "lib/serverspec/commands/redhat.rb", "lib/serverspec/commands/solaris.rb", "lib/serverspec/helper.rb", "lib/serverspec/helper/debian.rb", "lib/serverspec/helper/exec.rb", "lib/serverspec/helper/gentoo.rb", "lib/serverspec/helper/obsoleted.rb", "lib/serverspec/helper/puppet.rb", "lib/serverspec/helper/redhat.rb", "lib/serverspec/helper/solaris.rb", "lib/serverspec/helper/ssh.rb", "lib/serverspec/matchers.rb", "lib/serverspec/matchers/be_directory.rb", "lib/serverspec/matchers/be_enabled.rb", "lib/serverspec/matchers/be_file.rb", "lib/serverspec/matchers/be_group.rb", "lib/serverspec/matchers/be_grouped_into.rb", "lib/serverspec/matchers/be_installed.rb", "lib/serverspec/matchers/be_installed_by_gem.rb", "lib/serverspec/matchers/be_linked_to.rb", "lib/serverspec/matchers/be_listening.rb", "lib/serverspec/matchers/be_mode.rb", "lib/serverspec/matchers/be_owned_by.rb", "lib/serverspec/matchers/be_running.rb", "lib/serverspec/matchers/be_user.rb", "lib/serverspec/matchers/be_zfs.rb", "lib/serverspec/matchers/belong_to_group.rb", "lib/serverspec/matchers/contain.rb", "lib/serverspec/matchers/get_stdout.rb", "lib/serverspec/matchers/have_cron_entry.rb", "lib/serverspec/matchers/have_iptables_rule.rb", "lib/serverspec/setup.rb", "lib/serverspec/version.rb", "serverspec.gemspec", "spec/debian/commands_spec.rb", "spec/debian/matchers_spec.rb", "spec/gentoo/commands_spec.rb", "spec/gentoo/matchers_spec.rb", "spec/redhat/commands_spec.rb", "spec/redhat/matchers_spec.rb", "spec/solaris/commads_spec.rb", "spec/solaris/matchers_spec.rb", "spec/spec_helper.rb", "spec/support/shared_matcher_examples.rb"]
  s.homepage = "http://serverspec.org/"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.0"
  s.summary = "RSpec tests for your servers provisioned by Puppet, Chef or anything else"
  s.test_files = ["spec/debian/commands_spec.rb", "spec/debian/matchers_spec.rb", "spec/gentoo/commands_spec.rb", "spec/gentoo/matchers_spec.rb", "spec/redhat/commands_spec.rb", "spec/redhat/matchers_spec.rb", "spec/solaris/commads_spec.rb", "spec/solaris/matchers_spec.rb", "spec/spec_helper.rb", "spec/support/shared_matcher_examples.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<net-ssh>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<net-ssh>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<net-ssh>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
