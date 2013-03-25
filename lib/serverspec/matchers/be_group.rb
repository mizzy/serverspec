RSpec::Matchers.define :be_group do
  match do |actual|
    ssh_exec(RSpec.configuration.host, commands.check_group(actual))
    $? == 0
  end
end
