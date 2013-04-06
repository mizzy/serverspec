RSpec::Matchers.define :be_installed do
  match do |actual|
    ret = do_check(commands.check_installed(actual))
    ret[:exit_code] == 0
  end
end
