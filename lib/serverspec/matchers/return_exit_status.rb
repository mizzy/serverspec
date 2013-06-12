RSpec::Matchers.define :return_exit_status do |status|
  match do |command|
    command.return_exit_status?(status)
  end
end
