require 'singleton'

module Serverspec
  module Backend
    class Base
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
      
      def check_zero(cmd, *args)
        ret = run_command(commands.send(cmd, *args))
        ret[:exit_status] == 0
      end

      # Default action is to call check_zero with args
      def method_missing(meth, *args, &block)
        check_zero(meth, *args)
      end
    end
  end
end