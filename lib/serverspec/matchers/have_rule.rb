RSpec::Matchers.define :have_rule do |rule|
  match do |iptables|
    iptables.has_rule?(rule, @table, @chain)
  end
  chain :with_table do |table|
    @table = table
  end
  chain :with_chain do |chain|
    @chain = chain
  end
end
