RSpec::Matchers.define :return_stdout do |content|
  match do |command|
    if command.respond_to?(:return_stdout?)
      command.return_stdout?(content)
    else
      ret = backend.run_command(command)
      if content.instance_of?(Regexp)
        ret[:stdout] =~ content
      else
        ret[:stdout].strip == content
      end
    end
  end
end
