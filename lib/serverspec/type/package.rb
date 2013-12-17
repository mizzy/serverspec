module Serverspec
  module Type
    class Package < Base
      def installed?(provider, version)
        if provider.nil?
          backend.check_installed(@name, version)
        else
          check_method = "check_installed_by_#{provider}".to_sym

          unless backend.respond_to?(check_method) || commands.respond_to?(check_method)
            raise ArgumentError.new("`be_installed` matcher doesn't support #{provider}")
          end

          backend.send(check_method, @name, version)
        end
      end

      def version
        ret = backend.run_command(commands.get_package_version(@name))[:stdout].strip
        if ret.empty?
          nil
        else
          Version.new(ret)
        end
      end

      class Version < Gem::Version
        def <=>(other)
          other = Gem::Version.new(other) if other.is_a?(String)
          super(other)
        end
      end
    end
  end
end
