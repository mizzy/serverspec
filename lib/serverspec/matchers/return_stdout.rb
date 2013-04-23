RSpec::Matchers.define :return_stdout do |content|
  match do |command|
    ret = backend.do_check(command)
    if content.instance_of?(Regexp)
      ret[:stdout] =~ content
    else
      ret[:stdout].strip == content
    end
  end
end
