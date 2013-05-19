RSpec::Matchers.define :have_login_shell do |path_to_shell|
  match do |user|
    if user.respond_to?(:has_login_shell?)
      user.has_login_shell?(path_to_shell)
    else
      backend.check_login_shell(example, user, path_to_shell)
    end
  end
end

