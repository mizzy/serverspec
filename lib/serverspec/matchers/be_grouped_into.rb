RSpec::Matchers.define :be_grouped_into do |group|
  match do |file|
    backend.check_grouped(example, file, group)
  end
end
