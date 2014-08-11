module Serverspec::Type
  class PhpConfig < Base
    def value
      ret = @runner.run_command("php -r 'echo get_cfg_var( \"#{@name}\" );'")
      val = ret.stdout
      val = val.to_i if val.match(/^\d+$/)
      val
    end
  end
end
