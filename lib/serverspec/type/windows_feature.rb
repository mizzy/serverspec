module Serverspec::Type
  class WindowsFeature < Base
    def installed?(provider, version)
      @runner.check_feature_is_enabled(@name, provider)
    end
  end
end
