module Serverspec
  module Helper
    module Aix
      def commands
        Serverspec::Commands::Aix.new
      end
    end
  end
end
