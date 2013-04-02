require 'etc'

module Serverspec
  module SshHelper
    def ssh_exec(cmd, opt={})
      cmd = "sudo #{cmd}" if not RSpec.configuration.ssh.options[:user] == 'root'
      ssh_exec!(cmd)
    end

    private
    def ssh_exec!(command)
      stdout_data = ''
      stderr_data = ''
      exit_code   = nil
      exit_signal = nil

      ssh = RSpec.configuration.ssh
      ssh.open_channel do |channel|
        channel.request_pty do |ch, success|
          abort "Could not obtain pty " if !success
        end
        channel.exec("#{command}") do |ch, success|
          abort "FAILED: couldn't execute command (ssh.channel.exec)" if !success
          channel.on_data do |ch,data|
            stdout_data += data
          end

          channel.on_extended_data do |ch,type,data|
            stderr_data += data
          end

          channel.on_request("exit-status") do |ch,data|
            exit_code = data.read_long
          end

          channel.on_request("exit-signal") do |ch, data|
            exit_signal = data.read_long
          end
        end
      end
      ssh.loop
      { :stdout => stdout_data, :stderr => stderr_data, :exit_code => exit_code, :exit_signal => exit_signal }
    end

  end

  module RedHatHelper
    def commands
      Serverspec::Commands::RedHat.new
    end
  end

  module DebianHelper
    def commands
      Serverspec::Commands::Debian.new
    end
  end

  module GentooHelper
    def commands
      Serverspec::Commands::Gentoo.new
    end
  end

  module SolarisHelper
    def commands
      Serverspec::Commands::Solaris.new
    end
  end
end
