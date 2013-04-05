RSpec::Matchers.define :be_running do
  match do |process|
    ret = do_check(commands.check_running(process))
    if ret[:exit_code] == 1 || ret[:stdout] =~ /stopped/
      ret = do_check(commands.check_process(process))
    end
    ret[:exit_code] == 0
  end
end
