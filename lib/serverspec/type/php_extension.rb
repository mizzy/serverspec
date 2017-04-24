module Serverspec::Type
  class PhpExtension < Base
    def loaded?
      ret = @runner.run_command("php --ri '#{@name}'")

      return false if ret.exit_status.to_i > 0

      true
    end
  end
end
