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

    def rules
      if @rules_content.nil?
        @rules_content = @runner.run_command('/sbin/auditctl -l').stdout || ''
      end
      @rules_content
    end

    private

    def status_of(part)
      cmd = "/sbin/auditctl -s"
      status_str = @runner.run_command(cmd).stdout.chomp
      status_map = parse_status(status_str)
      status_map[part] || ''
    end

    def parse_status(status_str)
      map = nil
      if status_str =~ /^AUDIT_STATUS/ then
        map = status_str.split(' ')[1..-1].inject({}) { |res,elem| a = elem.split('='); res.store(a[0],a[1] || ''); res }
      else
        map = status_str.split("\n").inject({}) { |res,elem| a = elem.split(' '); res.store(a[0],a[1] || ''); res } 
      end
      map
    end

  end
end
