require 'serverspec/attributes'

module Serverspec
  module Helper
    module Attributes
      def attr
        Serverspec::Attributes.instance.attributes
      end
      def attr_set(attr)
        Serverspec::Attributes.instance.attributes(attr)
      end
    end
  end
end
