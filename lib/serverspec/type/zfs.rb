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

    def property
      get_property if @property.nil?
      @property
    end

    private
    def get_property
      @property = Hash.new
      @runner.get_zfs_property(@name).stdout.split(/\n/).each do |line|
        property, value = line.split(/\s+/)
        @property[property] = value
      end
    end
  end
end
