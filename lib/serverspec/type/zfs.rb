module Serverspec
  module Type
    class Zfs < Base
      def exists?
        @runner.check_zfs(@name)
      end

      def has_property?(property)
        @runner.check_zfs(@name, property)
      end

      def to_s
        'ZFS'
      end
    end
  end
end
