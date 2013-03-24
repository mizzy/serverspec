RSpec::Matchers.define :be_installed do
  match do |actual|
    ssh_exec(RSpec.configuration.host, commands.check_installed(actual))
    $? == 0
  end
end
