module Serverspec
  module Type
    class File < Base
      def file?
        backend.check_file(@name)
      end

      def socket?
        backend.check_socket(@name)
      end

      def directory?
        backend.check_directory(@name)
      end

      def contain(pattern, from, to)
        if (@from || @to).nil?
          cmd = backend.check_file_contain(@name, pattern)
        else
          cmd = backend.check_file_contain_within(@name, pattern, from, to)
        end
      end

      def mode?(mode)
        backend.check_mode(@name, mode)
      end

      def owned_by?(owner)
        backend.check_owner(@name, owner)
      end

      def grouped_into?(group)
        backend.check_grouped(@name, group)
      end

      def linked_to?(target)
        backend.check_link(@name, target)
      end

      def readable?(by_whom, by_user)
        if by_user != nil
          backend.check_access_by_user(@name, by_user, 'r')
        else
          backend.check_readable(@name, by_whom)
        end
      end

      def writable?(by_whom, by_user)
        if by_user != nil
          backend.check_access_by_user(@name, by_user, 'w')
        else
          backend.check_writable(@name, by_whom)
        end
      end

      def executable?(by_whom, by_user)
        if by_user != nil
          backend.check_access_by_user(@name, by_user, 'x')
        else
          backend.check_executable(@name, by_whom)
        end
      end

      def mounted?(attr, only_with)
        backend.check_mounted(@name, attr, only_with)
      end

      def match_md5checksum(md5sum)
        backend.check_file_md5checksum(@name, md5sum)
      end

    end
  end
end
