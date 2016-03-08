module Serverspec::Type
  class Interface < Base
    def exists?
      @runner.check_interface_exists(@name)
    end

    def speed
      ret = @runner.get_interface_speed_of(@name)
      val_to_integer(ret)
    end

    def mtu
      ret = @runner.get_interface_mtu_of(@name)
      val_to_integer(ret)
    end

    def has_ipv4_address?(ip_address)
      @runner.check_interface_has_ipv4_address(@name, ip_address)
    end

    def has_ipv6_address?(ip_address)
      @runner.check_interface_has_ipv6_address(@name, ip_address)
    end

    def ipv4_address
      @runner.get_interface_ipv4_address(@name).stdout.strip
    end

    def ipv6_address
      @runner.get_interface_ipv6_address(@name).stdout.strip
    end

    def up?
      ret = @runner.get_interface_link_state(@name)
      ret.stdout.strip == 'up'
    end

    private

    def val_to_integer(ret)
      val = ret.stdout.strip
      val = val.to_i if val.match(/^\d+$/)
      val
    end

  end
end
