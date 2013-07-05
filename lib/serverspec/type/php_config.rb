module Serverspec
  module Type
    class PhpConfig < Base
      def value
        ret = backend.run_command("php -r 'echo get_cfg_var( \"#{@name}\" );'")
        val = ret[:stdout]
        val = val.to_i if val.match(/^\d+$/)
        val
      end

      def to_s
        'php_config'
      end
    end
  end
end
