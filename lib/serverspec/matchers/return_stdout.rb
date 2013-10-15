RSpec::Matchers.define :return_stdout do |*args|
  match do |command|
    command.return_stdout?(*args)
  end
end
