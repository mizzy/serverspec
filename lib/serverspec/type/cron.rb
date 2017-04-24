module Serverspec::Type
  class Cron < Base
    def has_entry?(user, entry)
      @runner.check_cron_has_entry(user, entry)
    end

    def table
      @runner.get_cron_table.stdout
    end

    def to_s
      'Cron'
    end
  end
end
