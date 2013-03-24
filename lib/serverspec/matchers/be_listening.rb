RSpec::Matchers.define :be_listening do
  match do |actual|
    port = actual.gsub(/port\s+/, '')
    ssh_exec(RSpec.configuration.host, "netstat -tnl 2> /dev/null | grep ':#{port} '")
    $? == 0
  end
end
