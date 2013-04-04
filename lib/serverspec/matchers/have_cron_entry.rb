RSpec::Matchers.define :have_cron_entry do |entry|
  match do |actual|
    @user ||= 'root'
    ret = do_check(commands.check_cron_entry(@user, entry))
    ret[:exit_code] == 0
  end
  chain :with_user do |user|
    @user = user
  end
end
