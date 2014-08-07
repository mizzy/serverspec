RSpec::Matchers.define :have_site_application do |app|
  match do |subject|
    if subject.class.name == 'Serverspec::Type::IisWebsite'
      subject.has_site_application?(app, @pool, @physicalPath)
    else
      className = subject.class.name
      raise "not supported class #{className}"
    end
  end

  chain :with_pool do |pool|
    @pool = pool
  end
  
  chain :with_physicalPath do |physicalPath|
    @physicalPath = physicalPath
  end
end
