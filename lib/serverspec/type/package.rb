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
        ret = backend.run_command(commands.get_package_version(@name)).stdout.strip
        if ret.empty?
          nil
        else
          Version.new(ret)
        end
      end

      class Version
        include Comparable

        attr_reader :epoch, :version

        def initialize(val)
          matches = val.match(/^(?:(\d+):)?(\d[0-9a-zA-Z.+:~-]*)$/)
          if matches.nil?
            raise ArgumentError, "Malformed version number string #{val}"
          end
          @epoch   = matches[1].to_i
          @version = matches[2].to_s
        end

        def <=>(other)
          other = Version.new(other) if other.is_a?(String)
          rv    = @epoch <=> other.epoch
          return rv if rv != 0

          self.ver_array <=> other.ver_array
        end

        def ver_array
          val = @version
          re  = /^(?:(\d+)|(\D+))(.*)$/
          res = []
          until val.empty?
            matches = val.match(re)
            if matches[1].nil?
              # String
              matches[2].to_s.each_byte do |b|
                code_point = defined?("~".ord) ? "~".ord : ?~
                res << ((b == code_point) ? -2 : b)
              end
            else
              # Digits
              res << matches[1].to_i
            end
            val = matches[3].to_s
          end
          res << -1
        end
      end
    end
  end
end
