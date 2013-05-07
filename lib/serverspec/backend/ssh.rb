require 'serverspec/backend/exec'

module Serverspec
  module Backend
    class Ssh < Exec
      def run_command(cmd, opt={})
        cmd = "sudo #{cmd}" if not RSpec.configuration.ssh.options[:user] == 'root'
        ret = ssh_exec!(cmd)
        if ! @example.nil?
          @example.metadata[:command] = cmd
          @example.metadata[:stdout]  = ret[:stdout]
        end
        ret
      end

      private
      def ssh_exec!(command)
        stdout_data = ''
        stderr_data = ''
        exit_status   = nil
        exit_signal = nil

        ssh = RSpec.configuration.ssh
        ssh.open_channel do |channel|
          channel.request_pty do |ch, success|
            abort "Could not obtain pty " if !success
          end
          channel.exec("#{command}") do |ch, success|
            abort "FAILED: couldn't execute command (ssh.channel.exec)" if !success
            channel.on_data do |ch, data|
              if data =~ /^\[sudo\] password for/
                channel.send_data "#{RSpec.configuration.sudo_password}\n"
              else
                stdout_data += data
              end
            end

            channel.on_extended_data do |ch, type, data|
              stderr_data += data
            end

            channel.on_request("exit-status") do |ch, data|
              exit_status = data.read_long
            end

            channel.on_request("exit-signal") do |ch, data|
              exit_signal = data.read_long
            end
          end
        end
        ssh.loop
        { :stdout => stdout_data, :stderr => stderr_data, :exit_status => exit_status, :exit_signal => exit_signal }
      end
    end
  end
end
