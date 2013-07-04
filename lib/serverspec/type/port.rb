module Serverspec
  module Type
    class Port < Base
      def listening?(with)
        if with 
          check_method = "check_listening_with_#{with}".to_sym

          unless backend.respond_to?(check_method)
            raise ArgumentError.new("`be_listening` matcher doesn't support #{with}")
          end

          backend.send(check_method, @name)
        else
          backend.check_listening(@name)
        end
      end
    end
  end
end
