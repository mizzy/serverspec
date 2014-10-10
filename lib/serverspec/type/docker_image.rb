module Serverspec::Type
  class DockerImage < Base
    def exist?
      @runner.check_docker_inspect_noerr(@name)
    end

    def method_missing(meth, *args, &block)
      @runner.get_docker_inspect(@name, meth.to_s).stdout.strip
    end
  end
end
