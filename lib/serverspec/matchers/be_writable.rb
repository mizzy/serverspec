RSpec::Matchers.define :be_writable do
  match do |file|
    backend.check_writable(example, file, @by_whom)
  end
  chain :by do |by_whom|
    @by_whom = by_whom
  end
end
