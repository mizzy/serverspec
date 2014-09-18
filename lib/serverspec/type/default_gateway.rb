module Serverspec::Type
  class DefaultGateway < Base
    def ipaddress
      @runner.get_default_gateway(:gateway)
    end

    def interface
      @runner.get_default_gateway(:interface)
    end

    def to_s
      'Default Gateway'
    end
  end
end
