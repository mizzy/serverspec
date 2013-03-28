RSpec::Matchers.define :be_owned_by do |owner|
  match do |file|
    ret = ssh_exec(commands.check_owner(file, owner))
    ret[:exit_code] == 0
  end
end
