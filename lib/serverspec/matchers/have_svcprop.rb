RSpec::Matchers.define :have_svcprop do |property|
  match do |svc|
    backend.check_svcprop(svc, property, @value)
  end

  chain :with_value do |value|
    @value = value
  end
end
