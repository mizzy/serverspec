module Serverspec::Type
  class Ipfilter < Base
    def has_rule?(rule)
      @runner.check_ipfilter_has_rule(rule)
    end

    def to_s
      'ipfilter'
    end
  end
end
