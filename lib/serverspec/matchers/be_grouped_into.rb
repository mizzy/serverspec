RSpec::Matchers.define :be_grouped_into do |group|
  match do |file|
    if file.respond_to?(:grouped_into?)
      file.grouped_into?(group)
    else
      backend.check_grouped(example, file, group)
    end
  end
end
