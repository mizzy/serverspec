RSpec::Matchers.define :have_svcprops do |property|
  match do |svc|
    backend.check_svcprops(example, svc, property)
  end
end
