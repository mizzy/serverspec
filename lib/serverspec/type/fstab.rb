module Serverspec::Type
  class Fstab < Base
    def has_entry?(entry)
      @runner.check_fstab_has_entry(entry)
    end

    def to_s
      'Fstab'
    end
  end
end
