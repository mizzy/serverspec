RSpec::Matchers.define :be_running do
  match do |process|
    process.running?(@under, @level)
  end

  chain :under do |under|
    @under = under
  end
  
  chain :with_level do |level|
    @level = level
  end
end
