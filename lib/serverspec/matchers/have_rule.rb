RSpec::Matchers.define :have_rule do |rule|
  match do |subject|
    if subject.class.name == 'Serverspec::Type::Iptables'
      subject.has_rule?(rule, @table, @chain)
    else
      subject.has_rule?(rule)
    end
  end
  chain :with_table do |table|
    @table = table
  end
  chain :with_chain do |chain|
    @chain = chain
  end
end
