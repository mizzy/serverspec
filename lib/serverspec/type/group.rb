module Serverspec::Type
  class Group < Base
    def exists?
      @runner.check_group_exists(@name)
    end

    def gid
      @runner.get_group_gid(@name).stdout.to_i
    end

    def has_gid?(gid)
      @runner.check_group_has_gid(@name, gid)
    end
  end
end
