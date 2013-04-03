RSpec::Matchers.define :be_running do
  match do |actual|
    ret = ssh_exec(commands.check_running(actual))
    if ret[:exit_code] == 1 || ret[:stdout] =~ /stopped/
      ret = ssh_exec(commands.check_process(actual))
    end
    ret[:exit_code] == 0
  end
end
