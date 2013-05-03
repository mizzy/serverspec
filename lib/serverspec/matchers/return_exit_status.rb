RSpec::Matchers.define :return_exit_status do |status|
  match do |command|
    ret = backend.run_command(command)
    ret[:exit_status].to_i == status
  end
end
