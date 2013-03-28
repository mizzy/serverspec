RSpec::Matchers.define :be_mode do |mode|
  match do |file|
    ret = ssh_exec(commands.check_mode(file, mode))
    ret[:exit_code] == 0
  end
end
