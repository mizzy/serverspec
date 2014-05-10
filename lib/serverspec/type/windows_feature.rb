module Serverspec
  module Type
    class WindowsFeature < Base
      def installed?(provider, version)
        backend.check_windows_feature_enabled(@name, provider)
      end
    end
  end
end
