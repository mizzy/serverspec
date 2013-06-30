RSpec::Matchers.define :be_proc_running do |status|
  match do |command|
    if command.respond_to?(:be_proc_running?)
      command.proc_running(status)
    else
      ret = backend.run_command(command)
      ret[:exit_status] == 0
    end
  end
end
