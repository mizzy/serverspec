module Serverspec::Type
  class MysqlConfig < Base
    def value
      ret = @runner.run_command("mysqladmin variables 2> /dev/null | tr -d '|' | grep '#{@name}'")
      val = ret.stdout.match(/#{@name}\s+(.+)$/)[1].strip
      val = val.to_i if val.match(/^\d+$/)
      val
    end
  end
end
