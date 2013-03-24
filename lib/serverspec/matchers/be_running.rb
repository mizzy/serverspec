RSpec::Matchers.define :be_running do
  match do |actual|
    ssh_exec(RSpec.configuration.host, commands.check_running(actual))
    $? == 0
  end
end
