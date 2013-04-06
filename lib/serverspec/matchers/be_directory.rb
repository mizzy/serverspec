RSpec::Matchers.define :be_directory do
  match do |actual|
    ret = do_check(commands.check_directory(actual))
    ret[:exit_code] == 0
  end
end
