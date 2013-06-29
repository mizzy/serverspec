module Serverspec
  module Type
    class Interface < Base
      def speed
        ret = backend.run_command(commands.get_interface_speed_of(@name))
        val = ret[:stdout].strip
        val = val.to_i if val.match(/^\d+$/)
        val
      end
    end
  end
end
