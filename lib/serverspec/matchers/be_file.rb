RSpec::Matchers.define :be_file do
  match do |actual|
    ssh_exec(RSpec.configuration.host, "test -f #{actual} 2> /dev/null")
    $? == 0
  end
end
