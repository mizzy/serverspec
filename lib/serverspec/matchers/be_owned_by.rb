RSpec::Matchers.define :be_owned_by do |owner|
  match do |file|
    if file.respond_to?(:owned_by?)
      file.owned_by?(owner)
    else
      backend.check_owner(example, file, owner)
    end
  end
end
