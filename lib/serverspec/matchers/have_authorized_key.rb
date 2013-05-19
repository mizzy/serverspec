RSpec::Matchers.define :have_authorized_key do |key|
  match do |user|
    if user.respond_to?(:has_authorized_key?)
      user.has_authorized_key?(key)
    else
      backend.check_authorized_key(example, user, key)
    end
  end
end
