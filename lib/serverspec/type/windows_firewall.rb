module Serverspec::Type
  class WindowsFirewall < Base
    def exists?
      @runner.check_firewall_exists(@name)
    end

    def tcp?
      @runner.check_firewall_has_protocol(@name, 'TCP')
    end

    def has_localport?(port)
      @runner.check_firewall_has_localport(@name, port)
    end

    def inbound?
      @runner.check_firewall_has_direction(@name, 'Inbound')
    end

    def enabled?
      @runner.check_firewall_is_enabled(@name)
    end

    def allowed?
      @runner.check_firewall_has_action(@name, 'Allow')
    end

  end
end
