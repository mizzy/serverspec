require 'open3'

module Serverspec
  module Backend
    class Cmd < Base
      include PowerShell::ScriptHelper

      def run_command(cmd, opts={})
        script = create_script(cmd)
        result = execute_script %Q{powershell -encodedCommand #{encode_script(script)}}

        if @example
          @example.metadata[:command] = script
          @example.metadata[:stdout]  = result[:stdout] + result[:stderr]
        end
        { :stdout => result[:stdout], :stderr => result[:stderr],
          :exit_status => result[:status], :exit_signal => nil }
      end

      def execute_script script
        if Open3.respond_to? :capture3
          stdout, stderr, status = Open3.capture3(script)
          # powershell still exits with 0 even if there are syntax errors, although it spits the error out into stderr
          # so we have to resort to return an error exit code if there is anything in the standard error
          status = 1 if status == 0 and !stderr.empty?
          { :stdout => stdout, :stderr => stderr, :status => status }
        else
          stdout = `#{script} 2>&1`
          { :stdout => stdout, :stderr => nil, :status => $? }
        end
      end

      def check_os
        # Dirty hack for specs
        'Windows'
      end
    end
  end
end
