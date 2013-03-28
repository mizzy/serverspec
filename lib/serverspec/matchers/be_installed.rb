RSpec::Matchers.define :be_installed do
  match do |actual|
    ret = ssh_exec(commands.check_installed(actual))
    ret[:exit_code] == 0
  end
end
