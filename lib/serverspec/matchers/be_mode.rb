RSpec::Matchers.define :be_mode do |mode|
  match do |file|
    ret = ssh_exec(RSpec.configuration.host, commands.check_mode(file, mode))
    ret[:exit_code] == 0
  end
end
