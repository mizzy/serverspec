module Serverspec
  module Helper
    def ssh_exec(host, cmd, opt={})
      `ssh root@#{host} -o'StrictHostKeyChecking no' -o'UserKnownHostsFile /dev/null' #{cmd}`
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
end
