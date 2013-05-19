module Serverspec
  module Helper
    module Type
      types = %w(
        base
        service
        package
        port
        file
        cron
        command
      )

      types.each {|type| require "serverspec/type/#{type}" }

      types.each do |type|
        define_method type do |*args|
          name = args.first
          self.class.const_get('Serverspec').const_get('Type').const_get(type.capitalize).new(name)
        end
      end
    end
  end
end
