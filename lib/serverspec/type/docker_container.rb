module Serverspec::Type
  class DockerContainer < Base
    def present?
      @runner.check_docker_inspect_noerr(@name)
    end

    def running?
      state_running = @runner.get_docker_inspect(@name, '.State.Running').stdout.strip
      state_running == 'true'
    end

    def has_volume?(container_path, host_path = nil)
      volumes_str = @runner.get_docker_inspect(@name, '.Volumes').stdout.strip || ''
      volumes = volumes_str.sub(/^map\[/,'').sub(/\]$/,'').split(' ')

      volumes.any? do |elem|
	parts = elem.split(':')
        (host_path.nil?)?parts[0] == container_path : (parts[0] == container_path && parts[1] == host_path)
      end
    end

    def method_missing(meth, *args, &block)
      @runner.get_docker_inspect(@name, meth.to_s).stdout.strip
    end
  end
end
