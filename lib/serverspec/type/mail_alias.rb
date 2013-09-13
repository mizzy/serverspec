module Serverspec
  module Type
    class MailAlias < Base
      def aliased_to?(target)
        backend.check_mail_alias(@name, target)
      end
    end
  end
end
