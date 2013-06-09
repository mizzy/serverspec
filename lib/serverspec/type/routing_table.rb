module Serverspec
  module Type
    class RoutingTable < Base
      def has_entry?(entry)
        backend.check_routing_table(entry)
      end

      def to_s
        'Routing Table'
      end
    end
  end
end
