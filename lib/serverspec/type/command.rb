require 'multi_json'

module Serverspec::Type
  class Command < Base
    def stdout
      command_result.stdout
    end

    def stdout_as_json
      MultiJson.load(command_result.stdout)
    end

    def stderr
      command_result.stderr
    end

    def exit_status
      command_result.exit_status.to_i
    end

    private
    def command_result()
      @command_result ||= @runner.run_command(@name)
    end
  end
end
