module Serverspec
  module Helper
    module SmartOS
      def commands
        Serverspec::Commands::SmartOS.new
      end
    end
  end
end

