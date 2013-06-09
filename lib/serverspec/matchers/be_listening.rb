RSpec::Matchers.define :be_listening do
  match do |actual|
    if actual.respond_to?(:listening?)
      actual.listening?
    else
      port = actual.gsub(/port\s+/, '')
      backend.check_listening(port)
    end
  end
end
