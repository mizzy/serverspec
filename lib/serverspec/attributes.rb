require 'singleton'

module Serverspec
  class Attributes
    include Singleton
    def initialize
      @attr = {}
    end
    def attributes(attr=nil)
      if ! attr.nil?
        @attr = attr
      end
      @attr
    end
  end
end

