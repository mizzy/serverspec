RSpec::Matchers.define :be_listening do
  match do |port|
    port.listening?(@with)
  end

  chain :with do |with|
    @with = with 
  end
end
