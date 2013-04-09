RSpec::Matchers.define :be_installed do
  match do |name|
    if @provider.nil?
      backend.check_installed(name)
    elsif @provider == 'gem'
      backend.check_installed_by_gem(name, @version)
    end
  end
  chain :by do |provider|
    @provider = provider
  end
  chain :with_version do |version|
    @version = version
  end
end
