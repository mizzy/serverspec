module Serverspec
  module Type
    class Ipnat < Base
      def has_rule?(rule)
        backend.check_ipnat_rule(nil, rule)
      end

      def to_s
        'ipnat'
      end
    end
  end
end
