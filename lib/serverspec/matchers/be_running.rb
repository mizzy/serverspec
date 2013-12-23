RSpec::Matchers.define :be_running do
  match do |process|
    if subject.class.name == 'Serverspec::Type::Service'
      process.running?(@under)
    else
      process.running?
    end
  end

  chain :under do |under|
    @under = under
  end
end
