RSpec::Matchers.define :be_executable do
  match do |file|
    if @by_user != nil
      backend.check_access_by_user(example, 'x', file, @by_user)
    else
      backend.check_executable(example, file, @by_whom)
    end
  end
  chain :by do |by_whom|
    @by_whom = by_whom
  end
  chain :by_user do |by_user|
    @by_user = by_user
  end
end
