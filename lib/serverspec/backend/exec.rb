module Serverspec
  module Backend
    class Exec
      def initialize(commands)
        @commands ||= commands
      end

      def commands
        @commands
      end

      def do_check(cmd, opts={})
        stdout = `#{cmd} 2>&1`
        # In ruby 1.9, it is possible to use Open3.capture3, but not in 1.8
        #stdout, stderr, status = Open3.capture3(cmd)
        { :stdout => stdout, :stderr => nil,
          :exit_code => $?, :exit_signal => nil }
      end

      def check_zero(cmd, *args)
        ret = do_check(commands.send(cmd, *args))
        ret[:exit_code] == 0
      end

      # Default action is to call check_zero with args
      def method_missing(meth, *args, &block)
        # Remove example object from *args
        args.shift
        check_zero(meth, *args)
      end

      def check_installed_by_gem(example, package, version)
        ret = do_check(commands.check_installed_by_gem(package))
        res = ret[:exit_code] == 0
        if res && version
          res = false if not ret[:stdout].match(/\(#{version}\)/)
        end
        res
      end

      def check_running(example, process)
        ret = do_check(commands.check_running(process))
        if ret[:exit_code] == 1 || ret[:stdout] =~ /stopped/
          ret = do_check(commands.check_process(process))
        end
        ret[:exit_code] == 0
      end

      def check_running_under_supervisor(example, process)
        ret = do_check(commands.check_running_under_supervisor(process))
        ret[:exit_code] == 0 && ret[:stdout] =~ /RUNNING/
      end

      def check_readable(example, file, by_whom)
        mode = sprintf('%04s',do_check(commands.get_mode(file))[:stdout].strip)
        mode_octal = mode[0].to_i * 512 + mode[1].to_i * 64 + mode[2].to_i * 8 + mode[3].to_i * 1
        if by_whom.nil?
          mode_octal & 0444 != 0
        elsif by_whom == 'owner'
          mode_octal & 0400 != 0
        elsif by_whom == 'group'
          mode_octal & 0040 != 0
        elsif by_whom == 'others'
          mode_octal & 0004 != 0
        end
      end

      def check_writable(example, file, by_whom)
        mode = sprintf('%04s',do_check(commands.get_mode(file))[:stdout].strip)
        mode_octal = mode[0].to_i * 512 + mode[1].to_i * 64 + mode[2].to_i * 8 + mode[3].to_i * 1
        if by_whom.nil?
          mode_octal & 0222 != 0
        elsif by_whom == 'owner'
          mode_octal & 0200 != 0
        elsif by_whom == 'group'
          mode_octal & 0020 != 0
        elsif by_whom == 'others'
          mode_octal & 0002 != 0
        end
      end

      def check_executable(example, file, by_whom)
        mode = sprintf('%04s',do_check(commands.get_mode(file))[:stdout].strip)
        mode_octal = mode[0].to_i * 512 + mode[1].to_i * 64 + mode[2].to_i * 8 + mode[3].to_i * 1
        if by_whom.nil?
          mode_octal & 0111 != 0
        elsif by_whom == 'owner'
          mode_octal & 0100 != 0
        elsif by_whom == 'group'
          mode_octal & 0010 != 0
        elsif by_whom == 'others'
          mode_octal & 0001 != 0
        end
      end

    end
  end
end
