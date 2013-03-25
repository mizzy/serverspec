RSpec::Matchers.define :exists_user do
  match do |actual|
    ssh_exec(RSpec.configuration.host, commands.check_user_exists(actual))
    $? == 0
  end
end
