RSpec::Matchers.define :be_enabled do
  match do |actual|
    ret = do_check(commands.check_enabled(actual))
    ret[:exit_code] == 0
  end
end
