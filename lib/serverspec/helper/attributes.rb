require 'serverspec/attributes'

module Serverspec
  module Helper
    module Attributes
      def attr
        puts "Warning: attr method will be obsoleted. Please use property method instead."
        Serverspec::Attributes.instance.attributes
      end
      def attr_set(attr)
        puts "Warning: attr_set method will be obsoleted. Please use set_property method instead."
        Serverspec::Attributes.instance.attributes(attr)
      end
    end
  end
end
