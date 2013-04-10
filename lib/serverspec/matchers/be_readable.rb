RSpec::Matchers.define :be_readable do
  match do |file|
    backend.check_readable(example, file, @by_whom)
  end
  chain :by do |by_whom|
    @by_whom = by_whom
  end
end
