RSpec::Matchers.define :have_home_directory do |path_to_home|
  match do |user|
    backend.check_home_directory(example, user, path_to_home)
  end
end

