RSpec::Matchers.define :be_installed_by_gem do
  match do |name|
    puts <<EOF

***************************************************
The matcher be_isntalled_by_gem will be depricated.
Please use be_installed.by('gem') instead.
***************************************************

EOF
    backend.check_installed_by_gem(example, name, @version)
  end
  chain :with_version do |version|
    @version = version
  end
end
