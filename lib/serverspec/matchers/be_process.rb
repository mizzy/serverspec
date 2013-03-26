RSpec::Matchers.define :be_process do
  match do |actual|
    ret = ssh_exec(RSpec.configuration.host, commands.check_process(actual))
    ret[:exit_code] == 0
  end
end
