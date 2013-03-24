RSpec::Matchers.define :be_running do
  match do |actual|
    ssh_exec(RSpec.configuration.host, "service #{actual} status 2> /dev/null")
    $? == 0
  end
end
