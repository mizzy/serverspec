RSpec::Matchers.define :have_cron_entry do |entry|
  match do |actual|
    @user ||= 'root'
    backend.check_cron_entry(example, @user, entry)
  end
  chain :with_user do |user|
    @user = user
  end
end
