module Serverspec::Type
  class Ipnat < Base
    def has_rule?(rule)
      @runner.check_ipnat_has_rule(rule)
    end

    def to_s
      'ipnat'
    end
  end
end
