require 'spec_helper'

set :os, :family => 'base'

describe commands.command_class('mail_alias') do
  it { should be_an_instance_of(Specinfra::Command::Base::MailAlias) }
end

describe mail_alias('daemon') do
  it { should be_aliased_to "root" }
end

describe mail_alias('invalid-recipient') do
  it { should_not be_aliased_to "foo" }
end
