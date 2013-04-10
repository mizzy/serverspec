RSpec::Matchers.define :belong_to_group do |group|
  match do |user|
    backend.check_belonging_group(example, user, group)
  end
end
