RSpec::Matchers.define :be_linked_to do |target|
  match do |link|
    backend.check_link(example, link, target)
  end
end
