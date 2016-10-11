RSpec::Matchers.define :be_enabled do
  match do |subject|
    if subject.class.name == 'Serverspec::Type::Service'
      subject.enabled?(@level, @under)
    else
      subject.enabled?
    end
  end

  description do
    message = 'be enabled'
    message << " under #{@under}" if @under
    message << " with level #{@level}" if @level
    message
  end

  chain :with_level do |level|
    @level = level
  end

  chain :under do |under|
    @under = under
  end
end
