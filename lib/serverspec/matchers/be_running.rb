RSpec::Matchers.define :be_running do
  match do |process|
    process.running?(@under, @process_name)
  end

  chain :under do |under|
    @under = under
  end

  chain :with_process_name do |process_name|
    @process_name = process_name
  end
end
