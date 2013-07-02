module Serverspec
  module Type
    class php < Base
      def ini_value
        ret = backend.run_command("php -r 'echo ini_get( \"#{@name}\" );'")
        val = ret[:stdout].strip
        val = val.to_i if val.match(/^\d+$/)
        val
      end
    end
  end
end
