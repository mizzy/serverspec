RSpec::Matchers.define :have_iptables_rule do |rule|
  match do |iptables|
    backend.check_iptables_rule(example, rule, @table, @chain)
  end
  chain :with_table do |table|
    @table = table
  end
  chain :with_chain do |chain|
    @chain = chain
  end
end
