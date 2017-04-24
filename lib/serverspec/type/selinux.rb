module Serverspec::Type
  class Selinux < Base
    def disabled?
      @runner.check_selinux_has_mode('disabled')
    end

    def enforcing?(with_policy)
      @runner.check_selinux_has_mode('enforcing', with_policy)
    end

    def permissive?(with_policy)
      @runner.check_selinux_has_mode('permissive', with_policy)
    end

    def to_s
      'SELinux'
    end
  end
end
