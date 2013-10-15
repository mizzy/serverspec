RSpec::Matchers.define :return_stdout do |expected|
  match do |command|
    command.return_stdout?(expected)
  end
end
