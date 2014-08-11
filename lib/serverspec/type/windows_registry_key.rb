module Serverspec::Type
  class WindowsRegistryKey < Base
    def exists?
      @runner.check_registry_key_exists(@name)
    end

    def has_property?(property_name, property_type = :type_string)
      @runner.check_registry_key_has_property(@name, {:name => property_name, :type => property_type})
    end

    def has_value?(value)
      @runner.check_registry_key_has_value(@name, {:name => '', :type => :type_string, :value => value})
    end

    def has_property_value?(property_name, property_type, value)
      @runner.check_registry_key_has_value(@name, {:name => property_name, :type => property_type, :value => value})
    end
  end
end
