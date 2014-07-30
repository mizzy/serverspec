module Serverspec
  module Type
    class DefaultGateway < Base
      def ipaddress
        ret = @runner.get_routing_table_entry(:destination => 'default')
        ret.stdout =~ /^(\S+)(?: via (\S+))? dev (\S+).+(?:\r)?\n(?:default via (\S+))?/
        $2 ? $2 : $4
      end

      def interface
        ret = @runner.get_routing_table_entry(:destination => 'default')
        ret.stdout =~ /^(\S+)(?: via (\S+))? dev (\S+).+(?:\r)?\n(?:default via (\S+))?/
        $3
      end

      def to_s
        'Default Gateway'
      end
    end
  end
end
