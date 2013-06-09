RSpec::Matchers.define :have_uid do |uid|
  match do |user|
    if user.respond_to?(:has_uid?)
      user.has_uid?(uid)
    else
      backend.check_uid(user, uid)
    end
  end
end

