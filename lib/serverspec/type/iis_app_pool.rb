module Serverspec
  module Type
    class IisAppPool < Base
      def exists?()
        backend.check_iis_app_pool(@name)
      end

      def has_dotnet_version?(dotnet)
        backend.check_iis_app_pool_dotnet(@name, dotnet)
      end

      def has_32bit_enabled?()
        backend.check_32bit_enabled(@name)
      end

      def has_managed_pipeline_mode?(mode)
        backend.check_managed_pipeline_mode(@name, mode)
      end

      def has_idle_timeout?(minutes)
        backend.check_idle_timeout(@name, minutes)
      end

      def has_identity_type?(identity_type)
        backend.check_identity_type(@name, identity_type)
      end

      def has_periodic_restart?(minutes)
        backend.check_periodic_restart(@name, minutes)
      end

      def has_user_profile_enabled?()
        backend.check_user_profile(@name)
      end

      def has_username?(username)
        backend.check_username(@name, username)
      end

      def to_s
        %Q[IIS Application Pool "#{@name}"]
      end
    end
  end
end
