module Serverspec
  module Type
    class Iptables < Base
      def has_rule?(rule, table, chain)
        @runner.check_iptables_rule(rule, table, chain)
      end

      def to_s
        'iptables'
      end
    end
  end
end
