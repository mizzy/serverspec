RSpec::Matchers.define :contain do |expected|
  match do |actual|
    ssh_exec(RSpec.configuration.host, "\"grep -q '#{expected}' #{actual} \" 2> /dev/null")
    $? == 0
  end
end
