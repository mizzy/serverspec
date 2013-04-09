RSpec::Matchers.define :be_running do
  match do |process|
    if (@under)
      check_method = "check_running_under_#{@under}".to_sym

      unless backend.respond_to?(check_method)
        raise ArgumentError.new("`be_running` matcher doesn't support #{@under}")
      end

      backend.send(check_method, example, process)
    else
      backend.check_running(example, process)
    end

  end

  chain :under do |under|
    @under = under
  end
end
