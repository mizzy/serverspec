RSpec::Matchers.define :be_file do
  match do |actual|
    if actual.respond_to?(:file?)
      actual.file?
    else
      backend.check_file(example, actual)
    end
  end
end
