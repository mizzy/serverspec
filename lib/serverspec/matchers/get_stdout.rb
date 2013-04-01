RSpec::Matchers.define :get_stdout do |expected|
  match do |command|
    ret = ssh_exec(command)
    ret[:stdout] =~ /#{expected}/
  end
end
