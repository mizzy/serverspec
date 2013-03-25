RSpec::Matchers.define :be_user do
  match do |actual|
    ret = ssh_exec(RSpec.configuration.host, commands.check_user(actual))
    ret[:exit_code] == 0
  end
end
