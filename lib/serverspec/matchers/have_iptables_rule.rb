RSpec::Matchers.define :have_iptables_rule do |rule|
  match do |iptables|
    ret = do_check(commands.check_iptables_rule(rule, @table, @chain))
    ret[:exit_code] == 0
  end
  chain :with_table do |table|
    @table = table
  end
  chain :with_chain do |chain|
    @chain = chain
  end
end
