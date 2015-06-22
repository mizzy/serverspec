module Serverspec::Type
  class MysqlConfig < Base
    def value
      ret = @runner.run_command("mysqld --verbose --help 2> /dev/null | grep '^#{@name}'")
      val = ret.stdout.match(/#{@name}\s+(.+)$/)[1]
      val = val.to_i if val.match(/^\d+$/)
      val
    end
  end
end
