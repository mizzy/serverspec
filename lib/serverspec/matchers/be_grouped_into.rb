RSpec::Matchers.define :be_grouped_into do |group|
  match do |file|
    ret = ssh_exec(RSpec.configuration.host, commands.check_group(file, group))
    ret[:exit_code] == 0
  end
end
