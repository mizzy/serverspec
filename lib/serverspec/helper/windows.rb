module Serverspec
  module Helper
    module Windows
      def commands
        Serverspec::Commands::Windows.new
      end
    end
  end
end
