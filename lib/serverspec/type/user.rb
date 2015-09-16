module Serverspec::Type
  class User < Base
    def exists?
      @runner.check_user_exists(@name)
    end

    def belongs_to_group?(group)
      @runner.check_user_belongs_to_group(@name, group)
    end

    def belongs_to_primary_group?(group)
      @runner.check_user_belongs_to_primary_group(@name, group)
    end

    def has_uid?(uid)
      @runner.check_user_has_uid(@name, uid)
    end

    def has_home_directory?(path)
      @runner.check_user_has_home_directory(@name, path)
    end

    def has_login_shell?(shell)
      @runner.check_user_has_login_shell(@name, shell)
    end

    def has_authorized_key?(key)
      @runner.check_user_has_authorized_key(@name, key)
    end

    def minimum_days_between_password_change
      @runner.get_user_minimum_days_between_password_change(@name).stdout.to_i
    end

    def maximum_days_between_password_change
      @runner.get_user_maximum_days_between_password_change(@name).stdout.to_i
    end

    def encrypted_password
      @runner.get_user_encrypted_password(@name).stdout.strip
    end 
  end
end
