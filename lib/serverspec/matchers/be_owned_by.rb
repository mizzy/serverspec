RSpec::Matchers.define :be_owned_by do |owner|
  match do |file|
    ret = ssh_exec(RSpec.configuration.host, commands.check_owner(file, owner))
    ret[:exit_code] == 0
  end
end
