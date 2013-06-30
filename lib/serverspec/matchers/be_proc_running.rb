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


RSpec::Matchers.define :contain do |pattern|
  match do |file|
    if file.respond_to?(:contain)
      file.contain(pattern, @from, @to)
    else
      if (@from || @to).nil?
        cmd = backend.commands.check_file_contain(file, pattern)
      else
        cmd = backend.commands.check_file_contain_within(file, pattern, @from, @to)
      end
      ret = backend.run_command(cmd)
      ret[:exit_status] == 0
    end
  end

