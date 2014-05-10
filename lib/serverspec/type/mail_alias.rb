module Serverspec
  module Type
    class MailAlias < Base
      def aliased_to?(target)
        @runner.check_mail_alias(@name, target)
      end
    end
  end
end
