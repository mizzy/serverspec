RSpec::Matchers.define :belong_to_group do |group|
  match do |user|
    user.belongs_to_group?(group)
  end
end
