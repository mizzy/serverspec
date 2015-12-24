module Serverspec::Type
  class PhpConfig < Base
    def value
      extra = '';
      extra = extra + "-c #{@options[:ini]}" if @options.has_key?(:ini)
      ret = @runner.run_command("php #{extra} -r 'echo get_cfg_var( \"#{@name}\" );'")
      val = ret.stdout
      val = val.to_i if val.match(/^\d+$/)
      val
    end
  end
end
