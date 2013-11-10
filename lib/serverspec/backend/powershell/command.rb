module Serverspec
  module Backend
    module PowerShell
      class Command
        attr_reader :import_functions, :script
        def initialize &block
          @import_functions = []
          @script = ""
          instance_eval &block if block_given?
        end

        def using *functions
          functions.each { |f| import_functions << f }
        end

        def exec code
          @script = code
        end

        def convert_regexp(target)
          case target
          when Regexp
            target.source
          else
            target.to_s.gsub '/', ''
          end
        end

        def get_identity id
          raise "You must provide a specific Windows user/group" if id =~ /(owner|group|others)/
          identity = id || 'Everyone'
        end

        def to_s
          @script
        end
      end
    end
  end
end
