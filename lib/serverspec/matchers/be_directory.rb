RSpec::Matchers.define :be_directory do
  match do |actual|
    if actual.respond_to?(:directory?)
      actual.directory?
    else
      backend.check_directory(example, actual)
    end
  end
end
