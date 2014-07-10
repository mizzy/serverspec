module Serverspec
  module Type
    class Mysql < Base
      def accessible?(user='root', password=nil, database=nil)
        backend.check_mysql(@name, user, password, database)
      end
    end
  end
end
