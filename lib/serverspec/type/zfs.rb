module Serverspec
  module Type
    class Zfs < Base
      def exists?
        backend.check_zfs(@name)
      end

      def has_property?(property)
        backend.check_zfs(@name, property)
      end

      def to_s
        'ZFS'
      end
    end
  end
end
