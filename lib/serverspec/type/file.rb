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

      def mode?(mode)
        backend.check_mode(nil, @name, mode)
      end

      def owned_by?(owner)
        backend.check_owner(nil, @name, owner)
      end

      def grouped_into?(group)
        backend.check_grouped(nil, @name, group)
      end

      def linked_to?(target)
        backend.check_link(nil, @name, target)
      end
    end
  end
end
