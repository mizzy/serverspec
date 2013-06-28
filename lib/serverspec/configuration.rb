module Serverspec
  module Configuration
    class << self
      VALID_OPTIONS_KEYS = [:path, :pre_command, :stdout, :stderr].freeze
      attr_accessor(*VALID_OPTIONS_KEYS)
    
      def defaults
        VALID_OPTIONS_KEYS.inject({}) { |o, k| o.merge!(k => send(k)) }
      end
    end
  end
end
