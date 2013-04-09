RSpec::Matchers.define :be_executable do
  match do |file|
    backend.check_executable(file, @by_whom)
  end
  chain :by do |by_whom|
    @by_whom = by_whom
  end
end
