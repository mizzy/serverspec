module Serverspec::Type
  class Ppa < Base
    def exists?
      @runner.check_ppa_exists(@name)
    end

    def enabled?
      @runner.check_ppa_is_enabled(@name)
    end
  end
end
