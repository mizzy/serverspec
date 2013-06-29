module Serverspec
  module Helper
    module Type
      types = %w(
        base yumrepo service package port file cron command linux_kernel_parameter iptables host
        routing_table default_gateway selinux user group zfs ipnat ipfilter kernel_module interface
      )

      types.each {|type| require "serverspec/type/#{type}" }

      types.each do |type|
        define_method type do |*args|
          name = args.first
          self.class.const_get('Serverspec').const_get('Type').const_get(camelize(type)).new(name)
        end
      end

      def camelize(string)
        string.split("_").each {|s| s.capitalize! }.join("")
      end
    end
  end
end
