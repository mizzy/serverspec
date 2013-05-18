module Serverspec
  module Type
    class Cron < Base
      def has_entry?(user, entry)
        backend.check_cron_entry(nil, user, entry)
      end
      def to_s
        'Cron'
      end
    end
  end
end
