shared_examples_for 'support iptables have_rule matcher' do |rule|
  describe 'have_rule' do
    describe iptables do
      it { should have_rule rule }
    end

    describe iptables do
      it { should_not have_rule 'invalid-rule' }
    end
  end
end

shared_examples_for 'support iptables have_rule with_table and with_chain matcher' do |rule, table, chain|
  describe 'have_rule with_table and with_chain' do
    describe iptables do
      it { should have_rule(rule).with_table(table).with_chain(chain) }
    end

    describe iptables do
      it { should_not have_rule('invalid-rule').with_table(table).with_chain(chain) }
    end
  end
end
