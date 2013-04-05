RSpec::Matchers.define :get_stdout do |expected|
  match do |command|
    ret = backend.do_check(command)
    ret[:stdout] =~ /#{expected}/
  end
end
