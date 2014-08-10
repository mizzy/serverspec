RSpec::Matchers.define :belong_to_primary_group do |group|
  match do |user|
    user.belongs_to_primary_group?(group)
  end
end
