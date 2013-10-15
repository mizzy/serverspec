RSpec::Matchers.define :return_stderr do |*args|
  match do |command|
    command.return_stderr?(*args)
  end
end
