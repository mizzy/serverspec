module Serverspec::Type
  class Group < Base
    def exists?
      @runner.check_group_exists(@name)
    end

    def has_gid?(gid)
      @runner.check_group_has_gid(@name, gid)
    end

    def belongs_to_group?(group)
      @runner.check_user_belongs_to_group(@name, group)
    end

    def belongs_to_primary_group?(group)
      @runner.check_user_belongs_to_primary_group(@name, group)
    end
  end
end
