RSpec::Matchers.define :be_running do
  match do |process|
    backend.check_running(process)
  end
end
