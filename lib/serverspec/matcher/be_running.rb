RSpec::Matchers.define :be_running do
  match do |subject|
    if subject.class.name == 'Serverspec::Type::Service'
      subject.running?(@under)
    else
      subject.running?
    end
  end

  description do
    message = 'be running'
    message << " under #{@under}" if @under
    message
  end

  chain :under do |under|
    @under = under
  end
end
