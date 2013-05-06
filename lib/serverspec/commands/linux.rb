require 'shellwords'

module Serverspec
  module Commands
    class Linux < Base
      class NotImplementedError < Exception; end

      def check_iptables_rule rule, table=nil, chain=nil
        cmd = "iptables"
        cmd += " -t #{escape(table)}" if table
        cmd += " -S"
        cmd += " #{escape(chain)}" if chain
        cmd += " | grep -- #{escape(rule)}"
        cmd
      end

      def check_selinux mode
        "/usr/sbin/getenforce | grep -i -- #{escape(mode)}"
      end
    end
  end
end
