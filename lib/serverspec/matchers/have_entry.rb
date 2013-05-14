RSpec::Matchers.define :have_entry do |attr|
  match do |subject|
    backend.check_routing_table(example, attr)
  end
end
