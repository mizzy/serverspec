RSpec::Matchers.define :be_group do
  match do |actual|
    ret = do_check(commands.check_group(actual))
    ret[:exit_code] == 0
  end
end
