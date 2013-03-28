RSpec::Matchers.define :contain do |expected|
  match do |actual|
    ret = ssh_exec(commands.check_file_contain(actual, expected))
    ret[:exit_code] == 0
  end
end
