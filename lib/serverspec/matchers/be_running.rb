RSpec::Matchers.define :be_running do
  match do |actual|
    ret = ssh_exec(RSpec.configuration.host, commands.check_running(actual))
    ret[:exit_code] == 0
  end
end
