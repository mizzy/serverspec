RSpec::Matchers.define :be_file do
  match do |actual|
    ssh_exec(RSpec.configuration.host, commands.check_file(actual))
    $? == 0
  end
end
