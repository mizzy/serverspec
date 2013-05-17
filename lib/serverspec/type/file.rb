module Serverspec
  module Type
    class File < Base
      def file?
        backend.check_file(nil, @name)
      end

      def directory?
        backend.check_directory(nil, @name)
      end
    end
  end
end
