RSpec::Matchers.define :be_resolvable do
  match do |name|
    if name.respond_to?(:resolvable?)
      name.resolvable?(@type)
    else
      backend.check_resolvable(example, name, @type)
    end
  end
  chain :by do |type|
    @type = type
  end
end

