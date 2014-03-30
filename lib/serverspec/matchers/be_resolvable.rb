RSpec::Matchers.define :be_resolvable do
  match do |name|
    name.resolvable?(@type)
  end

  chain :by do |type|
    @type = type
  end
end
