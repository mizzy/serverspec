module Serverspec
  module Type
    class Package < Base
      def installed?(provider, version)
        if provider.nil?
          backend.check_installed(nil, @name)
        else
          if provider.include?('/')
            path = provider
            provider = provider.split('/').last
          else
            path = nil
          end
          check_method = "check_installed_by_#{provider}".to_sym

          unless backend.respond_to?(check_method) || commands.respond_to?(check_method)
            raise ArgumentError.new("`be_installed` matcher doesn't support #{provider}")
          end

          backend.send(check_method, nil, @name, version, path)
        end
      end
    end
  end
end
