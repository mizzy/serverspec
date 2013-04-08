RSpec::Matchers.define :be_zfs do |value|
  match do |zfs|
    ret = do_check(commands.check_zfs(zfs, @property, value))
    ret[:exit_code] == 0
  end

  chain :property do |property|
    @property = property
  end
end
