require 'serverspec/type/service'
require 'serverspec/type/package'

module Serverspec
  module Helper
    module Type
      %w( service package ).each do |type|
        define_method type do |name|
          self.class.const_get('Serverspec').const_get('Type').const_get(type.capitalize).new(name)
        end
      end
    end
  end
end
