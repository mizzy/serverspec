RSpec::Matchers.define :be_owned_by do |owner|
  match do |file|
    backend.check_owner(file, owner)
  end
end
