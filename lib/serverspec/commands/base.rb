module Serverspec
  module Commands
    class Base
      class NotImplementedError < Exception; end

      def check_enabled service
        raise NotImplementedError.new
      end

      def check_file file
        "test -f #{file}"
      end

      def check_directory directory
        "test -d #{directory}"
      end

      def check_user user
        "id #{user}"
      end

      def check_group group
        "getent group | grep -wq #{group}"
      end

      def check_installed package
        raise NotImplementedError.new
      end

      def check_listening port
        "netstat -tunl | grep ':#{port} '"
      end

      def check_running service
        "service #{service} status"
      end

      def check_process process
        "ps -e | grep -qw #{process}"
      end

      def check_file_contain file, expected_pattern
        "grep -q '#{expected_pattern}' #{file} "
      end

      def check_mode file, mode
        "stat -c %a #{file} | grep #{mode}"
      end

      def check_owner file, owner
        "stat -c %U #{file} | grep #{owner}"
      end

      def check_grouped file, group
        "stat -c %G #{file} | grep #{group}"
      end

      def check_cron_entry user, entry
        entry_escaped = entry.gsub(/\*/, '\\*')
        "crontab -u #{user} -l | grep '#{entry_escaped}'"
      end

      def check_link link, target
        "stat -c %N #{link} | grep #{target}"
      end
    end
  end
end
