module Serverspec::Type
  class EnvironmentVariable < Base
    def exists?
      @runner.check_environment_variable_exists(@name)
    end

    def value
      @runner.get_environment_variable_value(@name)
    end
  end
end
