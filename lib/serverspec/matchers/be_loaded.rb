RSpec::Matchers.define :be_loaded do
  match do |actual|
    if actual.respond_to?(:loaded?)
      actual.loaded?
    end
  end
end
