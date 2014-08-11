module Serverspec::Type
  class Cgroup < Base
    attr_accessor :subsystem
    def method_missing(meth)
      if @subsystem.nil?
        @subsystem = meth.to_s
        self
      else
        param = "#{@subsystem}.#{meth.to_s}"
        ret = @runner.run_command("cgget -n -r #{param} #{@name} | awk '{print $2}'")
        val = ret.stdout.strip
        val = val.to_i if val.match(/^\d+$/)
        val
      end
    end
  end
end
