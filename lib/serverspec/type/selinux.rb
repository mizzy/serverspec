module Serverspec
  module Type
    class Selinux < Base
      def disabled?
        backend.check_selinux('disabled')
      end

      def enforcing?
        backend.check_selinux('enforcing')
      end

      def permissive?
        backend.check_selinux('permissive')
      end

      def to_s
        'SELinux'
      end
    end
  end
end
