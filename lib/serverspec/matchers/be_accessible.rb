RSpec::Matchers.define :be_accessible do
  match do |service|
    service.accessible?(@user, @password, @database)
  end

  chain :with_user do |user|
    @user = user
  end

  chain :with_password do |password|
    @password = password
  end

  chain :with_database do |database|
    @database = database
  end
end
