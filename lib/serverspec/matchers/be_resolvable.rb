RSpec::Matchers.define :be_resolvable do
  match do |actual|
    backend.check_resolvable(example, actual, @type)
  end
  chain :by do |type|
    @type = type
  end
end
