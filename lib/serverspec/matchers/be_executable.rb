RSpec::Matchers.define :be_executable do
  match do |file|
    file.executable?(@by_whom, @by_user)
  end

  chain :by do |by_whom|
    @by_whom = by_whom
  end

  chain :by_user do |by_user|
    @by_user = by_user
  end
end
