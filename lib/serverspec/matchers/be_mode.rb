RSpec::Matchers.define :be_mode do |mode|
  match do |file|
    ret = do_check(commands.check_mode(file, mode))
    ret[:exit_code] == 0
  end
end
