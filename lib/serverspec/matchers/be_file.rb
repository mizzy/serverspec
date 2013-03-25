RSpec::Matchers.define :be_file do
  match do |actual|
    ret = ssh_exec(RSpec.configuration.host, commands.check_file(actual))
    ret[:exit_code] == 0
  end
end
