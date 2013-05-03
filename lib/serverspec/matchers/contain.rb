RSpec::Matchers.define :contain do |pattern|
  match do |file|
    if (@from || @to).nil?
      cmd = backend.commands.check_file_contain(file, pattern)
    else
      cmd = backend.commands.check_file_contain_within(file, pattern, @from, @to)
    end
    ret = backend.run_command(cmd)
    ret[:exit_status] == 0
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
