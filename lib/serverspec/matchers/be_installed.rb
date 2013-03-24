RSpec::Matchers.define :be_installed do
  match do |actual|
    ssh_exec(RSpec.configuration.host, "rpm -q #{actual} 2> /dev/null")
    $? == 0
  end
end
