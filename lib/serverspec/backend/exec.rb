require 'singleton'

module Serverspec
  module Backend
    class Exec
      include Singleton

      def set_commands(c)
        @commands = c
      end

      def set_example(e)
        @example = e
      end

      def commands
        @commands
      end

      def run_command(cmd, opts={})
        cmd = build_command(cmd)
        cmd = add_pre_command(cmd)
        stdout = `#{build_command(cmd)} 2>&1`
        # In ruby 1.9, it is possible to use Open3.capture3, but not in 1.8
        #stdout, stderr, status = Open3.capture3(cmd)

        if @example
          @example.metadata[:command] = cmd
          @example.metadata[:stdout]  = stdout
        end

        { :stdout => stdout, :stderr => nil,
          :exit_status => $?, :exit_signal => nil }
      end

      def build_command(cmd)
        path = Serverspec.configuration.path || RSpec.configuration.path
        if path
          cmd = "env PATH=#{path}:$PATH #{cmd}"
        end
        cmd
      end

      def add_pre_command(cmd)
        path = Serverspec.configuration.path || RSpec.configuration.path
        if Serverspec.configuration.pre_command
          cmd = "#{Serverspec.configuration.pre_command} && #{cmd}"
          cmd = "env PATH=#{path}:$PATH #{cmd}" if path
        end
        cmd
      end

      def check_zero(cmd, *args)
        ret = run_command(commands.send(cmd, *args))
        ret[:exit_status] == 0
      end

      # Default action is to call check_zero with args
      def method_missing(meth, *args, &block)
        check_zero(meth, *args)
      end

      def check_running(process)
        ret = run_command(commands.check_running(process))
        if ret[:exit_status] == 1 || ret[:stdout] =~ /stopped/
          ret = run_command(commands.check_process(process))
        end
        ret[:exit_status] == 0
      end

      def check_running_under_supervisor(process)
        ret = run_command(commands.check_running_under_supervisor(process))
        ret[:exit_status] == 0 && ret[:stdout] =~ /RUNNING/
      end

      def check_running_under_upstart(process)
        ret = run_command(commands.check_running_under_upstart(process))
        ret[:exit_status] == 0 && ret[:stdout] =~ /running/
      end

      def check_monitored_by_monit(process)
        ret = run_command(commands.check_monitored_by_monit(process))
        return false unless ret[:stdout] != nil && ret[:exit_status] == 0

        retlines = ret[:stdout].split(/[\r\n]+/).map(&:strip)
        proc_index = retlines.index("Process '#{process}'")
        return false unless proc_index
        
        retlines[proc_index+2].match(/\Amonitoring status\s+monitored\Z/) != nil
      end

      def check_readable(file, by_whom)
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

      def check_writable(file, by_whom)
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

      def check_executable(file, by_whom)
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

      def check_mounted(path, expected_attr, only_with)
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

      def check_routing_table(expected_attr)
        return false if ! expected_attr[:destination]
        ret = run_command(commands.check_routing_table(expected_attr[:destination]))
        return false if ret[:exit_status] != 0

        ret[:stdout] =~ /^(\S+)(?: via (\S+))? dev (\S+).+\r\n(?:default via (\S+))?/
        actual_attr = {
          :destination => $1,
          :gateway     => $2 ? $2 : $4,
          :interface   => expected_attr[:interface] ? $3 : nil
        }

        expected_attr.each do |key, val|
          return false if actual_attr[key] != val
        end
        true
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
        elsif os = run_command('uname -sr')[:stdout] && os =~ /SunOS/i
          if os =~ /5.10/
            'Solaris10'
          elsif run_command('grep -q SmartOS /etc/release')
            'SmartOS'
          else
            'Solaris'
          end
        elsif run_command('uname -s')[:stdout] =~ /Darwin/i
          'Darwin'
        else
          'Base'
        end
      end
    end
  end
end
