RSpec::Matchers.define :be_directory do
  match do |actual|
    ret = ssh_exec(commands.check_directory(actual))
    ret[:exit_code] == 0
  end
end
