module Serverspec::Type
  class IisAppPool < Base
    def exists?()
      @runner.check_iis_app_pool_exists(@name)
    end

    def has_dotnet_version?(dotnet)
      @runner.check_iis_app_pool_has_dotnet_version(@name, dotnet)
    end

    def has_32bit_enabled?()
      @runner.check_iis_app_pool_has_32bit_enabled(@name)
    end

    def has_idle_timeout?(minutes)
      @runner.check_iis_app_pool_has_idle_timeout(@name, minutes)
    end

    def has_identity_type?(identity_type)
      @runner.check_iis_app_pool_has_identity_type(@name, identity_type)
    end

    def has_periodic_restart?(minutes)
      @runner.check_iis_app_pool_has_periodic_restart(@name, minutes)
    end

    def has_user_profile_enabled?()
      @runner.check_iis_app_pool_has_user_profile(@name)
    end

    def has_username?(username)
      @runner.check_iis_app_pool_has_username(@name, username)
    end

    def has_managed_pipeline_mode?(mode)
      @runner.check_iis_app_pool_has_managed_pipeline_mode(@name, mode)
    end

    def to_s
      %Q[IIS Application Pool "#{@name}"]
    end
  end
end
