module Serverspec
  module Helper
    module Type
      types = %w(
        base cgroup command cron default_gateway file group host iis_website iis_app_pool interface
        ipfilter ipnat iptables kernel_module linux_kernel_parameter lxc mail_alias
        package php_config port process routing_table selinux service user yumrepo
        windows_feature windows_registry_key zfs
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
