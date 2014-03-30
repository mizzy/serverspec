RSpec::Matchers.define :be_readable do
  match do |file|
    file.readable?(@by_whom, @by_user)
  end

  chain :by do |by_whom|
    @by_whom = by_whom
  end

  chain :by_user do |by_user|
    @by_user = by_user
  end
end
