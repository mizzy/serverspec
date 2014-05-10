module Serverspec
  module Type
    class User < Base
      def exists?
        backend.check_user(@name)
      end

      def belongs_to_group?(group)
        backend.check_belonging_group(@name, group)
      end

      def has_uid?(uid)
        backend.check_uid(@name, uid)
      end

      def has_home_directory?(path)
        backend.check_home_directory(@name, path)
      end

      def has_login_shell?(shell)
        backend.check_login_shell(@name, shell)
      end

      def has_authorized_key?(key)
        backend.check_authorized_key(@name, key)
      end
    end
  end
end
