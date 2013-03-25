RSpec::Matchers.define :be_directory do
  match do |actual|
    ssh_exec(RSpec.configuration.host, commands.check_directory(actual))
    $? == 0
  end
end
