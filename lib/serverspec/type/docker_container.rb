module Serverspec::Type
  class DockerContainer < DockerBase
    def running?
      inspection['State']['Running']
    end

    def has_volume?(container_path, host_path)
      inspection['Volumes'][container_path] == host_path
    end

    def has_bindports?(container_port, host_port)
      inspection['HostConfig']['PortBindings'][container_port].each do |port|
        return true if port['HostPort'] == host_port
      end
      false
    end
  end
end
