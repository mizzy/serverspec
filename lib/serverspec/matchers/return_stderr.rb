RSpec::Matchers.define :return_stderr do |content|
  match do |command|
    if command.respond_to?(:return_stderr?)
      command.return_stderr?(content)
    else
      ret = backend.run_command(command)
      if content.instance_of?(Regexp)
        ret[:stderr] =~ content
      else
        ret[:stderr].strip == content
      end
    end
  end
end
