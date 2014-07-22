module Serverspec
  module Type
    class Selinux < Base
      def disabled?
        @runner.check_selinux_mode('disabled')
      end

      def enforcing?
        @runner.check_selinux_mode('enforcing')
      end

      def permissive?
        @runner.check_selinux_mode('permissive')
      end

      def to_s
        'SELinux'
      end
    end
  end
end
