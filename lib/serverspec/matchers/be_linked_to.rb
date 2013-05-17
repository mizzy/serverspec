RSpec::Matchers.define :be_linked_to do |target|
  match do |link|
    if link.respond_to?(:linked_to?)
      link.linked_to?(target)
    else
      backend.check_link(example, link, target)
    end
  end
end
