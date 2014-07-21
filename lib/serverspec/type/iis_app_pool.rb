module Serverspec
  module Type
    class IisAppPool < Base
      def exists?()
        @runner.check_iis_app_pool_exists(@name)
      end

      def has_dotnet_version?(dotnet)
        @runner.check_iis_app_pool_has_dotnet_version(@name, dotnet)
      end

      def to_s
        %Q[IIS Application Pool "#{@name}"]
      end
    end
  end
end
