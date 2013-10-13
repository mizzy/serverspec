module Serverspec
  module Helper
    module Plamo
      def commands
        Serverspec::Commands::Plamo.new
      end
    end
  end
end
