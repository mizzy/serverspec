RSpec::Matchers.define :be_writable do
  match do |file|
    if file.respond_to?(:writable?)
      file.writable?(@by_whom, @by_user)
    else
      if @by_user != nil
        backend.check_access_by_user(example, file, @by_user, 'w')
      else
        backend.check_writable(example, file, @by_whom)
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
