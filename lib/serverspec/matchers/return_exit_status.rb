RSpec::Matchers.define :return_exit_status do |status|
  match do |command|
    if command.respond_to?(:return_exit_status?)
      command.return_exit_status?(status)
    else
      ret = backend.run_command(command)
      ret[:exit_status].to_i == status
    end
  end
end
