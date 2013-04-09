RSpec::Matchers.define :be_mode do |mode|
  match do |file|
    backend.check_mode(example, file, mode)
  end
end
