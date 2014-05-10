module Serverspec
  module Type
    class Port < Base
      def listening?(protocol)
        if protocol
          protocol = protocol.to_s.downcase
          unless ["udp", "tcp", "tcp6", "udp6"].include?(protocol)
            raise ArgumentError.new("`be_listening` matcher doesn't support #{protocol}")
          end

          backend.check_listening_with_protocol(@name, protocol)
        else
          backend.check_listening(@name)
        end
      end
    end
  end
end
