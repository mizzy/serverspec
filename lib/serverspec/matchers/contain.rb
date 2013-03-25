RSpec::Matchers.define :contain do |expected|
  match do |actual|
    ret = ssh_exec(RSpec.configuration.host, commands.check_file_contain(actual, expected))
    ret[:exit_code] == 0
  end
end
