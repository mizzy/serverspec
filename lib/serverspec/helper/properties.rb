require 'serverspec/properties'

module Serverspec
  module Helper
    module Properties
      def property
        Serverspec::Properties.instance.properties
      end
      def set_property(prop)
        Serverspec::Properties.instance.properties(prop)
      end
    end
  end
end
