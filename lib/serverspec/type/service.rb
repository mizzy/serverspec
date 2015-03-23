module Serverspec::Type
  class Service < Base
    def enabled?(level)
      if level
        @runner.check_service_is_enabled(@name, level)
      else
        @runner.check_service_is_enabled(@name)
      end
    end

    def installed?(name, version)
      @runner.check_service_is_installed(@name)
    end

    def has_start_mode?(mode)
      @runner.check_service_has_start_mode(@name, mode)
    end

    def running?(under)
      if under
        check_method = "check_service_is_running_under_#{under}".to_sym
        @runner.send(check_method, @name)
      else
        @runner.check_service_is_running(@name)
      end
    end

    def monitored_by?(monitor)
      check_method = "check_service_is_monitored_by_#{monitor}".to_sym
      res = @runner.send(check_method, @name)
    end

    def has_property?(property)
      @runner.check_service_has_property(@name, property)
    end

    def property
      get_property if @property.nil?
      @property
    end

    private
    def get_property
      @property = {}
      props = @runner.get_service_property(@name).stdout
      props.split(/\n/).each do |line|
        property, _type, *value = line.split(/\s+/)
        @property[property] = value.join(' ')
      end
    end
  end
end
