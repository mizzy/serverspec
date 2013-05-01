RSpec::Matchers.define :have_login_shell do |path_to_shell|
  match do |user|
    backend.check_login_shell(example, user, path_to_shell)
  end
end

