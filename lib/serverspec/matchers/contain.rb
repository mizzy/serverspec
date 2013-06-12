RSpec::Matchers.define :contain do |pattern|
  match do |file|
    file.contain(pattern, @from, @to)
  end
  # for contain(pattern).from(/A/).to(/B/)
  chain :from do |from|
    @from = Regexp.new(from).inspect
  end
  chain :to do |to|
    @to = Regexp.new(to).inspect
  end
  # for contain(pattern).after(/A/)
  chain :after do |after|
    @from = Regexp.new(after).inspect
  end
  # for contain(pattern).before(/B/)
  chain :before do |before|
    @to = Regexp.new(before).inspect
  end
end
