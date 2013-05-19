module Serverspec
  module Type
    class User < Base
      def exists?
        backend.check_user(nil, @name)
      end

      def belongs_to_group?(group)
        backend.check_belonging_group(nil, @name, group)
      end

      def has_uid?(uid)
        backend.check_uid(nil, @name, uid)
      end

      def has_home_directory?(path)
        backend.check_home_directory(nil, @name, path)
      end

      def has_login_shell?(shell)
        backend.check_login_shell(nil, @name, shell)
      end

      def has_authorized_key?(key)
        backend.check_authorized_key(nil, @name, key)
      end
    end
  end
end
