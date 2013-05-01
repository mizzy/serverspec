RSpec::Matchers.define :have_authorized_key do |key|
  match do |user|
    backend.check_authorized_key(example, user, key)
  end
end
