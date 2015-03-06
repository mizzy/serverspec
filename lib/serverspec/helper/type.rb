module Serverspec
  module Helper
    module Type
      types = %w(
        base bridge bond cgroup command cron default_gateway file fstab group host
        iis_website iis_app_pool interface ipfilter ipnat iptables
        ip6tables kernel_module linux_kernel_parameter lxc mail_alias
        package php_config port ppa process routing_table selinux
        selinux_module service user yumrepo windows_feature
        windows_hot_fix windows_registry_key windows_scheduled_task zfs
        docker_base docker_image docker_container x509_certificate x509_private_key
      )

      types.each {|type| require "serverspec/type/#{type}" }

      types.each do |type|
        define_method type do |*args|
          name = args.first
          eval "Serverspec::Type::#{type.to_camel_case}.new(name)"
        end
      end
    end
  end
end
