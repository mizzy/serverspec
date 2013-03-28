RSpec::Matchers.define :be_group do
  match do |actual|
    ret = ssh_exec(commands.check_group(actual))
    ret[:exit_code] == 0
  end
end
