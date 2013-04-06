RSpec::Matchers.define :be_installed_by_gem do
  match do |name|
    ret = do_check(commands.check_installed_by_gem(name))
    res = ret[:exit_code] == 0
    if res && @version
      res = false if not ret[:stdout].match(/\(#{@version}\)/)
    end
    res
  end
  chain :with_version do |version|
    @version = version
  end
end
