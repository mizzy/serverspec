module Serverspec::Type
  class RoutingTable < Base
    def has_entry?(entry)
      @runner.check_routing_table_has_entry(entry)
    end

    def to_s
      'Routing Table'
    end
  end
end
