module Serverspec::Type
  class Hdfs < Base
    def value 
      ret = @runner.get_hdfs_value(@name)
      val = ret.stdout.strip
      val
    end
  end
end
