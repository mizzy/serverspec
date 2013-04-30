RSpec::Matchers.define :have_uid do |uid|
  match do |user|
    backend.check_uid(example, user, uid)
  end
end

