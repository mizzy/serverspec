RSpec::Matchers.define :be_mode do |mode|
  match do |file|
    backend.check_mode(file, mode)
  end
end
