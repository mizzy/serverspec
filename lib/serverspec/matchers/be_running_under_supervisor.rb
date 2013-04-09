RSpec::Matchers.define :be_running_under_supervisor do
  match do |process|
    backend.check_running_under_supervisor(process)
  end
end
