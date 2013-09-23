module Serverspec
  module Backend
    module PowerShell
      module ScriptHelper
        def build_command(cmd)
          path = Serverspec.configuration.path || RSpec.configuration.path
          if path
            cmd.strip!
            cmd = 
<<-EOF
$env:path = "#{path};$env:path"
#{cmd}
EOF
          end
          cmd
        end

        def add_pre_command(cmd)
          path = Serverspec.configuration.path || RSpec.configuration.path
          if Serverspec.configuration.pre_command
            cmd.strip!
            cmd = 
<<-EOF
if (#{Serverspec.configuration.pre_command})
{
#{cmd}
}
EOF
            cmd = "$env:path = \"#{path};$env:path\"\n#{cmd}" if path
          end
          cmd
        end

        def encode_script script
          script_text = script.chars.to_a.join("\x00").chomp
          script_text << "\x00" unless script_text[-1].eql? "\x00"
          script_text = script_text.encode('ASCII-8BIT')
          Base64.strict_encode64(script_text)
        end

        def create_script command
          script = build_command(command.script)
          script = add_pre_command(script)
          ps_functions = command.import_functions.map { |f| File.read(File.join(File.dirname(__FILE__), 'support', f)) }
        <<-EOF
$exitCode = 1
try {
  #{ps_functions.join("\n")}
  $success = (#{script})
  if ($success -is [Boolean] -and $success) { $exitCode = 0 }
} catch {
  Write-Output $_.Exception.Message
}
Write-Output "Exiting with code: $exitCode"
exit $exitCode
          EOF
        end
      end
    end
  end
end