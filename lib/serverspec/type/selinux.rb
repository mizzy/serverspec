module Serverspec
  module Type
    class Selinux < Base
      def disabled?
        @runner.check_selinux('disabled')
      end

      def enforcing?
        @runner.check_selinux('enforcing')
      end

      def permissive?
        @runner.check_selinux('permissive')
      end

      def to_s
        'SELinux'
      end
    end
  end
end
