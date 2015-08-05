module Serverspec::Type
  class LinuxAuditSystem < Base
    def initialize(name=nil)
      @name = 'linux_audit_system'
      @runner = Specinfra::Runner
      @rules_content = nil
    end

    def enabled?
      status_of('enabled') == '1'
    end

    def running?
      pid = status_of('pid')
      (!pid.nil? && pid.size > 0 && pid != '0')
    end

    private

    def rules
      if @rules_content.nil?
        @rules_content = @runner.run_command('/sbin/auditctl -l').stdout
#.split("\n").map(&:chomp)
      end
      @rules_content || []
    end

    def status_of(part)
      cmd = "/sbin/auditctl -s | grep \"^#{part}\" | awk '{ print $2 }'"
	@runner.run_command(cmd).stdout.chomp
    end
  end
end
