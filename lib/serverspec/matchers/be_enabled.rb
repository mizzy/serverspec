RSpec::Matchers.define :be_enabled do
  match do |actual|
    ssh_exec(RSpec.configuration.host, "chkconfig --list #{actual} 2> /dev/null | grep 3:on")
    $? == 0
  end
end
