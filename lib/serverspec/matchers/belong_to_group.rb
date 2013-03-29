RSpec::Matchers.define :belong_to_group do |group|
  match do |user|
    ret = ssh_exec(commands.check_belonging_group(user, group))
    ret[:exit_code] == 0
  end
end
