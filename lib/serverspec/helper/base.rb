module Serverspec
  module Helper
    module Base
      def commands
        Serverspec::Commands::Base.new
      end
    end
  end
end
