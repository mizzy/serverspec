RSpec::Matchers.define :be_executable do
  match do |file|
    if file.respond_to?(:executable?)
      file.executable?(@by_whom, @by_user)
    else
      if @by_user != nil
        backend.check_access_by_user(file, @by_user, 'x')
      else
        backend.check_executable(file, @by_whom)
      end
    end
  end
  chain :by do |by_whom|
    @by_whom = by_whom
  end
  chain :by_user do |by_user|
    @by_user = by_user
  end
end
