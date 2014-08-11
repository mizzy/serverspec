module Serverspec::Type
  class Zfs < Base
    def exists?
      @runner.check_zfs_exists(@name)
    end

    def has_property?(property)
      @runner.check_zfs_has_property(@name, property)
    end

    def to_s
      'ZFS'
    end
  end
end
