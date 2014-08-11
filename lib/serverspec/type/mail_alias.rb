module Serverspec::Type
  class MailAlias < Base
    def aliased_to?(target)
      @runner.check_mail_alias_is_aliased_to(@name, target)
    end
  end
end
