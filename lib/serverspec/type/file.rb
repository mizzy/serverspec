module Serverspec
  module Type
    class File < Base
      def file?
        backend.check_file(nil, @name)
      end

      def directory?
        backend.check_directory(nil, @name)
      end

      def contain(pattern, from, to)
        if (@from || @to).nil?
          cmd = backend.check_file_contain(nil, @name, pattern)
        else
          cmd = backend.check_file_contain_within(nil, @name, pattern, from, to)
        end
      end
    end
  end
end
