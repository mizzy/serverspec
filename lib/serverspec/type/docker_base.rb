require 'multi_json'

module Serverspec::Type
  class DockerBase < Base
    def exist?
      get_inspection.success?
    end

    def [](key)
      value = inspection
      key.split('.').each do |k|
        is_index = k.start_with?('[') && k.end_with?(']')
        value = value[is_index ? k.to_i : k]
      end
      value
    end

    def inspection
      return @inspection if @inspection
      @inspection = ::MultiJson.load(get_inspection.stdout)[0]
    end

    private
    def get_inspection
      return @get_inspection if @get_inspection
      @get_inspection = @runner.run_command("docker inspect #{@name}")
    end
  end
end
