module Serverspec
  module Type
    class Selinux < Base
      def disabled?
        backend.check_selinux(nil, 'disabled')
      end

      def enforcing?
        backend.check_selinux(nil, 'enforcing')
      end

      def permissive?
        backend.check_selinux(nil, 'permissive')
      end

      def to_s
        'SELinux'
      end
    end
  end
end
