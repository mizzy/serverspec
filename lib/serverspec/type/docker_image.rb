module Serverspec::Type
  class DockerImage < Base
    def present?
      @runner.check_docker_inspect_noerr(@name)
    end

    def has_setting?(setting_name, value)
      @runner.get_docker_inspect(@name, setting_name).stdout.strip == value.to_s
    end

    def method_missing(meth, *args, &block)
      @runner.get_docker_inspect(@name, meth.to_s).stdout.strip
    end
  end
end
