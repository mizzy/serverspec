RSpec::Matchers.define :have_site_application do |app|
  match do |subject|
    if subject.class.name == 'Serverspec::Type::IisWebsite'
      subject.has_site_application?(app, @pool, @physical_path)
    else
      className = subject.class.name
      raise "not supported class #{className}"
    end
  end

  chain :with_pool do |pool|
    @pool = pool
  end
  
  chain :with_physical_path do |physical_path|
    @physical_path = physical_path
  end
end
