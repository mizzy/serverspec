require 'date'

module Serverspec
  module Type
    class File < Base
      attr_accessor :content

      def file?
        @runner.check_file(@name)
      end

      def socket?
        @runner.check_socket(@name)
      end

      def directory?
        @runner.check_directory(@name)
      end

      def contain(pattern, from, to)
        if pattern.is_a?(Array)
          @runner.check_file_contain_lines(@name, pattern, from, to)
        else
          if (from || to).nil?
            @runner.check_file_contain(@name, pattern)
          else
            @runner.check_file_contain_within(@name, pattern, from, to)
          end
        end
      end

      def mode?(mode)
        @runner.check_mode(@name, mode)
      end

      def owned_by?(owner)
        @runner.check_owner(@name, owner)
      end

      def grouped_into?(group)
        @runner.check_grouped(@name, group)
      end

      def linked_to?(target)
        @runner.check_link(@name, target)
      end

      def readable?(by_whom, by_user)
        if by_user != nil
          @runner.check_access_by_user(@name, by_user, 'r')
        else
          @runner.check_readable(@name, by_whom)
        end
      end

      def writable?(by_whom, by_user)
        if by_user != nil
          @runner.check_access_by_user(@name, by_user, 'w')
        else
          @runner.check_writable(@name, by_whom)
        end
      end

      def executable?(by_whom, by_user)
        if by_user != nil
          @runner.check_access_by_user(@name, by_user, 'x')
        else
          @runner.check_executable(@name, by_whom)
        end
      end

      def mounted?(attr, only_with)
        @runner.check_mounted(@name, attr, only_with)
      end

      def immutable?
        backend.check_immutable(@name)
      end

      def match_checksum(checksum)
        @runner.check_file_checksum(@name, checksum)
      end

      def match_md5checksum(md5sum)
        @runner.check_file_md5checksum(@name, md5sum)
      end

      def match_sha256checksum(sha256sum)
        @runner.check_file_sha256checksum(@name, sha256sum)
      end

      def content
        if @content.nil?
          @content = @runner.run_command(commands.get_file_content(@name)).stdout
        end
        @content
      end

      def version?(version)
        @runner.check_file_version(@name, version)
      end

      def mtime
        d = backend.get_file_mtime(@name).stdout.strip
        DateTime.strptime(d, '%s').new_offset(DateTime.now.offset)
      end

      def size
        backend.get_file_size(@name).stdout.strip.to_i
      end
    end
  end
end
