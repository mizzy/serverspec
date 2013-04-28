RSpec::Matchers.define :run_with do |param_value|
  match do |param_name|
    backend.check_kernel_parameter(example, param_name, param_value)
  end
end
