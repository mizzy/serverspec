require 'date'
require 'multi_json'
require 'yaml'

module Serverspec::Type
  class File < Base
    attr_accessor :content

    def file?
      cmd = Specinfra.command.get(:check_file_is_file, @name)
      @inspection = Specinfra.backend.build_command(cmd.to_s)
      @runner.check_file_is_file(@name)
    end

    def block_device?
      @runner.check_file_is_block_device(@name)
    end

    def character_device?
      @runner.check_file_is_character_device(@name)
    end

    def socket?
      @runner.check_file_is_socket(@name)
    end

    def directory?
      @runner.check_file_is_directory(@name)
    end

    def symlink?
      @runner.check_file_is_symlink(@name)
    end

    def pipe?
      @runner.check_file_is_pipe(@name)
    end

    def contain(pattern, from, to)
      if pattern.is_a?(Array)
        @runner.check_file_contains_lines(@name, pattern, from, to)
      else
        if (from || to).nil?
          @runner.check_file_contains(@name, pattern)
        else
          @runner.check_file_contains_within(@name, pattern, from, to)
        end
      end
    end

    def mode?(mode)
      @runner.check_file_has_mode(@name, mode)
    end

    def owned_by?(owner)
      @runner.check_file_is_owned_by(@name, owner)
    end

    def grouped_into?(group)
      @runner.check_file_is_grouped(@name, group)
    end

    def linked_to?(target)
      @runner.check_file_is_linked_to(@name, target)
    end

    def readable?(by_whom, by_user)
      if by_user != nil
        @runner.check_file_is_accessible_by_user(@name, by_user, 'r')
      else
        @runner.check_file_is_readable(@name, by_whom)
      end
    end

    def writable?(by_whom, by_user)
      if by_user != nil
        @runner.check_file_is_accessible_by_user(@name, by_user, 'w')
      else
        @runner.check_file_is_writable(@name, by_whom)
      end
    end

    def executable?(by_whom, by_user)
      if by_user != nil
        @runner.check_file_is_accessible_by_user(@name, by_user, 'x')
      else
        @runner.check_file_is_executable(@name, by_whom)
      end
    end

    def mounted?(attr, only_with)
      @runner.check_file_is_mounted(@name, attr, only_with)
    end

    def immutable?
      @runner.check_file_is_immutable(@name)
    end

    def exists?
      @runner.check_file_exists(@name)
    end

    def md5sum
      @runner.get_file_md5sum(@name).stdout.strip
    end

    def sha256sum
      @runner.get_file_sha256sum(@name).stdout.strip
    end

    def content
      if @content.nil?
        @content = @runner.get_file_content(@name).stdout
      end
      @content
    end

    def content_as_json
      @content_as_json = MultiJson.load(content) if @content_as_json.nil?
      @content_as_json
    end

    def content_as_yaml
      @content_as_yaml = YAML.load(content) if @content_as_yaml.nil?
      @content_as_yaml
    end

    def group
      @runner.get_file_owner_group(@name).stdout.strip
    end

    def version?(version)
      @runner.check_file_has_version(@name, version)
    end

    def link_target
      @runner.get_file_link_target(@name).stdout.strip
    end

    def mode
      @runner.get_file_mode(@name).stdout.strip
    end

    def mtime
      d = @runner.get_file_mtime(@name).stdout.strip
      DateTime.strptime(d, '%s').new_offset(DateTime.now.offset)
    end

    def owner
      @runner.get_file_owner_user(@name).stdout.strip
    end

    def size
      @runner.get_file_size(@name).stdout.strip.to_i
    end

    def selinux_label
      @runner.get_file_selinuxlabel(@name).stdout.strip
    end
  end
end
