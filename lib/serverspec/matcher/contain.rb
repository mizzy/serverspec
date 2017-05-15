RSpec::Matchers.define :contain do |pattern|
  match do |resource|
    if resource.is_a?(String)
      from = @from
      to = @to
      if from
        from = from.gsub('/', '.*')
      end
      if to
        to = to.gsub('/', '.*')
      end
      resource.match(Regexp.new([from, pattern, to].compact.join, Regexp::MULTILINE))
    else
      resource.contain(pattern, @from, @to)
    end
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
