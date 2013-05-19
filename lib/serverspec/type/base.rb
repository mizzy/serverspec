module Serverspec
  module Type
    class Base
      def initialize(name=nil)
        @name = name
      end

      def to_s
       type = self.class.name.split(':')[-1]
        %Q!#{type} "#{@name}"!
      end
    end
  end
end
