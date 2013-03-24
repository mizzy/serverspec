RSpec::Matchers.define :be_enabled do
  match do |actual|
    ssh_exec(RSpec.configuration.host, commands.check_enabled(actual))
    $? == 0
  end
end
