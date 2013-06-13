RSpec::Matchers.define :be_running do
  match do |process|
    process.running?(@under)
  end

  chain :under do |under|
    @under = under
  end
end
