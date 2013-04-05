RSpec::Matchers.define :be_grouped_into do |group|
  match do |file|
    ret = do_check(commands.check_grouped(file, group))
    ret[:exit_code] == 0
  end
end
