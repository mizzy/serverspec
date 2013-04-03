RSpec::Matchers.define :contain do |expected|
  match do |actual|
    if (@from || @to).nil?
      cmd = commands.check_file_contain(actual, expected)
    else
      cmd = commands.check_file_contain_within(actual, expected, @from, @to)
    end
    ret = ssh_exec(cmd)
    ret[:exit_code] == 0
  end
  chain :from do |from|
    @from = Regexp.new(from).inspect
  end
  chain :to do |to|
    @to = Regexp.new(to).inspect
  end
end
