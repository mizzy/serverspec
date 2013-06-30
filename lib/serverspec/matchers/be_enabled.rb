RSpec::Matchers.define :be_enabled do
  match do |subject|
    if subject.class.name == 'Serverspec::Type::Service'
       subject.enabled?(@level)
    else
      subject.enabled?
    end
  end

  chain :with_level do |level|
    @level = level
  end
end
