module Serverspec::Type
  class Base
    
    attr_reader :name
    
    def initialize(name=nil, options = {})
      @name    = name
      @options = options
      @runner  = Specinfra::Runner
    end

    def to_s
      type = self.class.name.split(':')[-1]
      type.gsub!(/([a-z\d])([A-Z])/, '\1 \2')
      type.capitalize!
      %Q!#{type} "#{@name}"!
    end

    def inspect
      if defined?(PowerAssert)
        @inspection
      else
        to_s
      end
    end

    def to_ary
      to_s.split(" ")
    end
  end
end
