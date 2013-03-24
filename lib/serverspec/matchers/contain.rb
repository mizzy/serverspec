RSpec::Matchers.define :contain do |expected|
  match do |actual|
    ssh_exec(RSpec.configuration.host, commands.check_file_contain(actual, expected))
    $? == 0
  end
end
