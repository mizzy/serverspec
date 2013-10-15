RSpec::Matchers.define :return_stderr do |content|
  match do |command|
    command.return_stderr?(content)
  end
end
