RSpec::Matchers.define :be_user do
  match do |actual|
    ret = do_check(commands.check_user(actual))
    ret[:exit_code] == 0
  end
end
