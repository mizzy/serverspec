module Serverspec
  module Helper
    def ssh_exec(host, cmd, opt={})
      `ssh root@#{host} -o'StrictHostKeyChecking no' -o'UserKnownHostsFile /dev/null' #{cmd}`
    end
  end
end

