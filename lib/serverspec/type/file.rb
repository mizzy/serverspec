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

      def readable?(by_whom, by_user)
        if by_user != nil
          backend.check_access_by_user(nil, @name, by_user, 'r')
        else
          backend.check_readable(nil, @name, by_whom)
        end
      end

      def writable?(by_whom, by_user)
        if by_user != nil
          backend.check_access_by_user(nil, @name, by_user, 'w')
        else
          backend.check_writable(nil, @name, by_whom)
        end
      end

      def executable?(by_whom, by_user)
        if by_user != nil
          backend.check_access_by_user(nil, @name, by_user, 'x')
        else
          backend.check_executable(nil, @name, by_whom)
        end
      end

      def mounted?(attr, only_with)
        backend.check_mounted(nil, @name, attr, only_with)
      end

      def match_md5checksum(md5sum)
        backend.check_file_md5checksum(nil, @name, md5sum)
      end

    end
  end
end
