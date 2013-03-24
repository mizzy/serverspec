RSpec::Matchers.define :be_listening do
  match do |actual|
    port = actual.gsub(/port\s+/, '')
    ssh_exec(RSpec.configuration.host, commands.check_listening(port))
    $? == 0
  end
end
