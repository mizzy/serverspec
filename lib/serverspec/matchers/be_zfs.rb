RSpec::Matchers.define :be_zfs do
  match do |zfs|
    backend.check_zfs(zfs, @property)
  end

  chain :with do |property|
    @property = property
  end
end
