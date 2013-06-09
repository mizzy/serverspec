RSpec::Matchers.define :be_readable do
  match do |file|
    if file.respond_to?(:readable?)
      file.readable?(@by_whom, @by_user)
    else
      if @by_user != nil
        backend.check_access_by_user(file, @by_user, 'r')
      else
        backend.check_readable(file, @by_whom)
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
