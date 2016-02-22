RSpec::Matchers.define :be_enabled do
  match do |subject|
    if subject.class.name == 'Serverspec::Type::Service'
      subject.enabled?(@level)
    else
      subject.enabled?
    end
  end

  description do
    message = 'be enabled'
    message << " with level #{@level}" if @level
    message
  end

  chain :with_level do |level|
    @level = level
  end
end
