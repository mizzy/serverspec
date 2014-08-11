module Serverspec::Type
  class Yumrepo < Base
    def exists?
      @runner.check_yumrepo_exists(@name)
    end

    def enabled?
      @runner.check_yumrepo_is_enabled(@name)
    end
  end
end
