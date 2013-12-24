module Serverspec
  module Type
    class Process < Base

      def running?
        pid = backend.run_command(commands.get_process(@name, "pid"))[:stdout]
        not pid.empty?
      end

      def to_ary
        ["process", @name]
      end

      def method_missing(meth)
        ret = backend.run_command(commands.get_process(@name, meth.to_s))
        val = ret[:stdout].strip
        val = val.to_i if val.match(/^\d+$/)
        val
      end

    end
  end
end
