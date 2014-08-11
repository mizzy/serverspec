module Serverspec::Type
  class LinuxKernelParameter < Base
    def value
      ret = @runner.run_command("/sbin/sysctl -q -n #{@name}")
      val = ret.stdout.strip
      val = val.to_i if val.match(/^\d+$/)
      val
    end
  end
end
