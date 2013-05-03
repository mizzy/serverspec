RSpec::Matchers.define :be_resolvable do
  match do |name|
    backend.check_resolvable(example, name, @type)
  end
  chain :by do |type|
    @type = type
  end
end
