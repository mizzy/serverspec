RSpec::Matchers.define :have_entry do |entry|
  match do |subject|
    if subject.class.name == 'Serverspec::Type::Cron'
       subject.has_entry?(@user, entry)
    elsif subject.respond_to?(:has_entry?)
      subject.has_entry?(entry)
    end
  end
  # For cron type
  chain :with_user do |user|
    @user = user
  end
end
