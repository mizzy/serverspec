RSpec::Matchers.define :have_home_directory do |path_to_home|
  match do |user|
    if user.respond_to?(:has_home_directory?)
      user.has_home_directory?(path_to_home)
    else
      backend.check_home_directory(example, user, path_to_home)
    end
  end
end

