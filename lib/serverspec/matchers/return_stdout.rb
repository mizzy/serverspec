RSpec::Matchers.define :return_stdout do |content|
  match do |command|
    command.return_stdout?(content)
  end
end
