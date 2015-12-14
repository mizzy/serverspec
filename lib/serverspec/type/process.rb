module Serverspec::Type
  class Process < Base
    def running?
      pid = @runner.get_process(@name, :format => "pid=").stdout
      not pid.empty?
    end

    def user
      get_column("user")
    end

    def group
      get_column("group")
    end

    def count
      @runner.count_process(@name).stdout.strip.to_i
    end

    def method_missing(meth)
      get_column(meth.to_s)
    end

    def get_column(keyword)
      ret = @runner.get_process(@name, :format => "#{keyword}=")
      val = ret.stdout.strip
      val = val.to_i if val.match(/^\d+$/)
      val
    end
  end
end
