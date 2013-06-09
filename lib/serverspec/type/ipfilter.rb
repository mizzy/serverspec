module Serverspec
  module Type
    class Ipfilter < Base
      def has_rule?(rule)
        backend.check_ipfilter_rule(rule)
      end

      def to_s
        'ipfilter'
      end
    end
  end
end
