require 'serverspec/type/service'

module Serverspec
  module Helper
    module Type
      def service name
        Serverspec::Type::Service.new(name)
      end
    end
  end
end
