module Serverspec::Type
  class DockerContainer < DockerBase
    def running?
      inspection['State']['Running'] && !inspection['State']['Restarting']
    end

    def has_volume?(container_path, host_path)
      if (inspection['Mounts'])
        check_volume(container_path, host_path)
      else
        check_volume_pre_1_8(container_path, host_path)
      end
    end

    private
    def check_volume(container_path, host_path)
      inspection['Mounts'].find {|mount|
        mount['Destination'] == container_path &&
        mount['Source'] == host_path
      }
    end

    def check_volume_pre_1_8(container_path, host_path)
      inspection['Volumes'][container_path] == host_path
    end
  end
end
