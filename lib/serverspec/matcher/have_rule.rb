RSpec::Matchers.define :have_rule do |rule|
  match do |subject|
    if subject.class.name == 'Serverspec::Type::Iptables' || subject.class.name == 'Serverspec::Type::Ip6tables'
      subject.has_rule?(rule, @table, @chain)
    else
      subject.has_rule?(rule)
    end
  end

  description do
    message = %Q{have rule "#{rule}"}
    message << " with table #{@table}" if @table
    message << ' and' if @table && @chain
    message << " with chain #{@chain}" if @chain
    message
  end

  chain :with_table do |table|
    @table = table
  end

  chain :with_chain do |chain|
    @chain = chain
  end
end
