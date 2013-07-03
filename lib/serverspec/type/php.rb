module Serverspec
  module Type
    class Php < Base
      def match_ini_value(value)
        backend.check_php_ini_value(@name, value)
      end

      def to_s
        'php'
      end
    end
  end
end
