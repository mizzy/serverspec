module Serverspec
  module Backend
    class Exec
      def initialize(commands)
        @commands ||= commands
      end

      def commands
        @commands
      end

      def run_command(cmd, opts={})
        stdout = `#{cmd} 2>&1`
        # In ruby 1.9, it is possible to use Open3.capture3, but not in 1.8
        #stdout, stderr, status = Open3.capture3(cmd)

        if ! @example.nil?
          @example.metadata[:command] = cmd
          @example.metadata[:stdout]  = stdout
        end

        { :stdout => stdout, :stderr => nil,
          :exit_status => $?, :exit_signal => nil }
      end

      def check_zero(cmd, *args)
        ret = run_command(commands.send(cmd, *args))
        ret[:exit_status] == 0
      end

      # Default action is to call check_zero with args
      def method_missing(meth, *args, &block)
        # Remove example object from *args
        @example = args.shift
        check_zero(meth, *args)
      end

      def check_installed_by_gem(example, package, version)
        @example = example
        ret = run_command(commands.check_installed_by_gem(package))
        res = ret[:exit_status] == 0
        if res && version
          res = false if not ret[:stdout].match(/\(#{version}\)/)
        end
        res
      end

      def check_running(example, process)
        @example = example
        ret = run_command(commands.check_running(process))
        if ret[:exit_status] == 1 || ret[:stdout] =~ /stopped/
          ret = run_command(commands.check_process(process))
        end
        ret[:exit_status] == 0
      end

      def check_running_under_supervisor(example, process)
        @example = example
        ret = run_command(commands.check_running_under_supervisor(process))
        ret[:exit_status] == 0 && ret[:stdout] =~ /RUNNING/
      end

      def check_readable(example, file, by_whom)
        @example = example
        mode = sprintf('%04s',run_command(commands.get_mode(file))[:stdout].strip)
        mode = mode.split('')
        mode_octal = mode[0].to_i * 512 + mode[1].to_i * 64 + mode[2].to_i * 8 + mode[3].to_i * 1
        case by_whom
        when nil
          mode_octal & 0444 != 0
        when 'owner'
          mode_octal & 0400 != 0
        when 'group'
          mode_octal & 0040 != 0
        when 'others'
          mode_octal & 0004 != 0
        end
      end

      def check_writable(example, file, by_whom)
        @example = example
        mode = sprintf('%04s',run_command(commands.get_mode(file))[:stdout].strip)
        mode = mode.split('')
        mode_octal = mode[0].to_i * 512 + mode[1].to_i * 64 + mode[2].to_i * 8 + mode[3].to_i * 1
        case by_whom
        when nil
          mode_octal & 0222 != 0
        when 'owner'
          mode_octal & 0200 != 0
        when 'group'
          mode_octal & 0020 != 0
        when 'others'
          mode_octal & 0002 != 0
        end
      end

      def check_executable(example, file, by_whom)
        @example = example
        mode = sprintf('%04s',run_command(commands.get_mode(file))[:stdout].strip)
        mode = mode.split('')
        mode_octal = mode[0].to_i * 512 + mode[1].to_i * 64 + mode[2].to_i * 8 + mode[3].to_i * 1
        case by_whom
        when nil
          mode_octal & 0111 != 0
        when 'owner'
          mode_octal & 0100 != 0
        when 'group'
          mode_octal & 0010 != 0
        when 'others'
          mode_octal & 0001 != 0
        end
      end

      def check_mounted(example, path, expected_attr, only_with)
        @example = example
        ret = run_command(commands.check_mounted(path))
        if expected_attr.nil? || ret[:exit_status] != 0
          return ret[:exit_status] == 0
        end

        mount = ret[:stdout].scan(/\S+/)
        actual_attr    = { :device => mount[0], :type => mount[4] }
        mount[5].gsub(/\(|\)/, '').split(',').each do |option|
          name, val = option.split('=')
          if val.nil?
            actual_attr[name.to_sym] = true
          else
            val = val.to_i if val.match(/^\d+$/)
            actual_attr[name.to_sym] = val
          end
        end

        if ! expected_attr[:options].nil?
          expected_attr.merge!(expected_attr[:options])
          expected_attr.delete(:options)
        end

        if only_with
          actual_attr == expected_attr
        else
          expected_attr.each do |key, val|
            return false if actual_attr[key] != val
          end
          true
        end
      end

      def check_os
        if run_command('ls /etc/redhat-release')[:exit_status] == 0
          'RedHat'
        elsif run_command('ls /etc/system-release')[:exit_status] == 0
          'RedHat' # Amazon Linux
        elsif run_command('ls /etc/debian_version')[:exit_status] == 0
          'Debian'
        elsif run_command('ls /etc/gentoo-release')[:exit_status] == 0
          'Gentoo'
        elsif run_command('uname -s')[:stdout] =~ /SunOS/i
          'Solaris'
        elsif run_command('uname -s')[:stdout] =~ /Darwin/i
          'Darwin'
        end
      end

    end
  end
end
