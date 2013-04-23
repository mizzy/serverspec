RSpec::Matchers.define :return_stderr do |content|
  match do |command|
    ret = backend.do_check(command)
    if content.instance_of?(Regexp)
      ret[:stderr] =~ content
    else
      ret[:stderr].strip == content
    end
  end
end
