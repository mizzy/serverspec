module Serverspec::Type
  class Kvm < Base
    def exists?
      @runner.check_kvm_guest_exists(@name)
    end

    def running?
      @runner.check_kvm_guest_is_running(@name)
    end

    def enabled?
      @runner.check_kvm_guest_is_enabled(@name)
    end

    def to_s
      'KVM'
    end
  end
end
