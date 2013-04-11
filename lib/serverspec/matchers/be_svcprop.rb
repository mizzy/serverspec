RSpec::Matchers.define :be_svcprop do |property|
  match do |svc|
    backend.check_svcprop(example, svc, property)
  end
end
