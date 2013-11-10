module Serverspec
  module Type
    class Cgroup < Base
      attr_accessor :subsystem
      def method_missing(meth)
        if @subsystem.nil?
          @subsystem = meth.to_s
          return self
        else
          param = "#{@subsystem}.#{meth.to_s}"
          ret = backend.run_command("cgget -n -r #{param} #{@name} | awk '{print $2}'")
          val = ret[:stdout].strip
          val = val.to_i if val.match(/^\d+$/)
          val
        end
      end
    end
  end
end
