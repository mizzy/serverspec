module Serverspec
  module Type
    class Ip6tables < Base
      def has_rule?(rule, table, chain)
        backend.check_ip6tables_rule(rule, table, chain)
      end

      def to_s
        'ip6tables'
      end
    end
  end
end
