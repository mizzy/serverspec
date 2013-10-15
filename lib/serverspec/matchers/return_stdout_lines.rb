RSpec::Matchers.define :return_stdout_lines do |*args|
  match do |command|
    command.return_stdout_lines?(*args)
  end
end
