RSpec::Matchers.define :be_file do
  match do |actual|
    ret = do_check(commands.check_file(actual))
    ret[:exit_code] == 0
  end
end
