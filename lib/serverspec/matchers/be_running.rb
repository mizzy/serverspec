RSpec::Matchers.define :be_running do
  match do |process|
    ret = ssh_exec(commands.check_running(process))
    if ret[:exit_code] == 1 || ret[:stdout] =~ /stopped/
      ret = ssh_exec(commands.check_process(process))
    end
    ret[:exit_code] == 0
  end
end
