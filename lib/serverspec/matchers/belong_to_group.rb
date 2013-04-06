RSpec::Matchers.define :belong_to_group do |group|
  match do |user|
    ret = do_check(commands.check_belonging_group(user, group))
    ret[:exit_code] == 0
  end
end
