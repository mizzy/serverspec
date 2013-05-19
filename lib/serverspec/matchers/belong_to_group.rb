RSpec::Matchers.define :belong_to_group do |group|
  match do |user|
    if user.respond_to?(:belongs_to_group?)
      user.belongs_to_group?(group)
    else
      backend.check_belonging_group(example, user, group)
    end
  end
end

